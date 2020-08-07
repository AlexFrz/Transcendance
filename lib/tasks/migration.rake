##
# Use this behind the scenes to migrate files from your filesystem to Amazon S3
# %: rake paperclip_migration:migrate_to_s3
##

namespace :attachments do  
    desc "migrate files from filesystem to s3"
    task :migrate_to_s3 => :environment do
      require 'aws'
  
      # Load credentials
      s3_options = YAML.load_file(File.join(Rails.root, 'config/s3.yml'))[Rails.env].symbolize_keys
      bucket = s3_options[:bucket]
      
      # Establish S3 connection
      s3_options.delete(:bucket)
      AWS::S3::Base.establish_connection!(s3_options)
      
      # determine the models to migrate
      klasses = [:article, :event, :user]
      
      klasses.each do |klass_sym|
        if @klass = real_klass(klass_sym)
          if @klass.respond_to?(:attachment_definitions) && definitions = @klass.attachment_definitions
            
            total_items  = @klass.count
            current_item = 1
            
            @klass.all.each do |record|
              definitions.each_pair do |column, value|
                attachment = record.send(column.to_sym)
                
                # NOTE: If the application is configured to use S3 already, 
                # calling exists? won't work as expected because paperclip will automatically look on Amazon.
                if !attachment.exists?
                  total_items -= 1
                  next
                end
                
                styles = value[:styles].keys
                styles.push(:original)
                
                styles.each do |style|
                  
                  # whatever mapping needed to where your files will live on S3
                  # in my case, I changed the URL when migrating to S3
                  path = attachment.url(style.to_sym).gsub('/system/files', '')
                  file = attachment.to_file(style.to_sym)
                  
                  # skip if we already have this file on S3
                  next if AWS::S3::S3Object.exists?(path, bucket)
                  
                  begin
                    print "uploading: #{style.to_sym}..."
                    AWS::S3::S3Object.store(path, file, bucket, :access => :public_read)
                    print " done.\n"
                  rescue AWS::S3::NoSuchBucket => e
                    AWS::S3::Bucket.create(bucket)
                    retry
                  rescue AWS::S3::ResponseError => e
                    raise
                  end
                end
                
                # fancy output
                percent_complete = ((current_item.to_f / total_items.to_f) * 100).round(2)
                
                puts "Completed: #{current_item} / #{total_items}: ~#{percent_complete}%"
                
                current_item += 1
              end
            end
            
          else
            puts "There are no paperclip attachments defined for: #{@klass.to_s}"
          end
        else
          puts "#{klass_sym.to_s.classify} is not an existing model."
        end
      end
    end
    
    def real_klass(key)
      key.to_s.classify.constantize
    rescue
    end
  end
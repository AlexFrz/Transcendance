<template>
  <div id="app">
    <p>{{ message }}</p>
  </div>
</template>

<script>
app.get("/favicon.ico", (req, res) => res.status(204));
app.get("/", (req, res) => res.status(204));

export default {
  data: function() {
    return {
      message: "Transcendance",
    };
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

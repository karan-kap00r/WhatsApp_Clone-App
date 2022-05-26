const express = require("express");
var http = require("http");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);

//middlewre
app.use(express.json());
var clients = {};
const routes = require("./routes");
app.use("/routes",routes);

app.use("/uploads",express.static("uploads"));

io.on("connection", (socket) => {
  console.log("connected");
  console.log(socket.id, "has joined");
  socket.on("signin", (id) => {
    console.log(id);
    clients[id] = socket;
    console.log(clients);
  });
  socket.on("message", (msg) => {
    console.log(msg);
    let targetId = msg.targetId;
    if (clients[targetId]) clients[targetId].emit("message", msg);
  });
});
app.route("/check").get((req,res)=>{
return res.json("your app is working fine");
})
server.listen(port, "0.0.0.0", () => {
  console.log("server started");
});
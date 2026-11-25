//require trafficligt.js
const traffic = require("./trafficlight");

//Export API
module.exports = function (app) {
    //welcome message
    /**
     *  /api/welcome: welcome message
     */
    app.get("/api/welcome", (req, res) => {
        res.status(200).json({
            message: "Welcome to the M324 traffic light API"
        });
    });

    /**
     * /api/trafficlight
     */
    app.get("/api/trafficlight", (req, res) => {
        // no color given: the traffic light is out of order
        res.status(200).json({
            color: null,
            message: traffic.trafficLight()
        });
    });
    /**
     * /api/trafficlight/:color
     * color is a parameter i.e. /api/trafficlight/red
     */
    app.get("/api/trafficlight/:color", (req, res) => {
        const color = req.params.color;
        const message = traffic.trafficLight(color);
        if (message === undefined) {
            // unknown color, e.g. /api/trafficlight/blue
            res.status(404).json({color: color, message: `Unknown color: ${color}`});
            return;
        }
        res.status(200).json({color: color, message: message});
    });
};

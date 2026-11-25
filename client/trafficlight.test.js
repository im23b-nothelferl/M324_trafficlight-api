//require supertest
const request = require("supertest");
//url of localserver is assigned to app
const app = process.env.API_URL || "http://localhost:3000";

describe("GET /api/welcome", () => {
    it("welcome message", async () => {
        const res = await request(app)
            .get("/api/welcome")
            .set("Accept", "application/json");
        expect(res.statusCode).toBe(200);
        expect(res.headers["content-type"]).toMatch(/json/);
        expect(res.body.message)
            .toBe("Welcome to the M324 traffic light API");
    });
});

describe("GET /api/trafficlight", () => {
    it("out of order", async () => {
        const res = await request(app)
            .get("/api/trafficlight")
            .set("Accept", "application/json");
            //be aware of empty spaces
        expect(res.statusCode).toBe(200);
        expect(res.body.color).toBeNull();
        expect(res.body.message).toBe("OUT OF ORDER");
    });
});

describe("GET /api/trafficlight/:color", () => {
    it("red", async () => {
        const res = await request(app)
            .get("/api/trafficlight/red")
            .set("Accept", "application/json");
        expect(res.statusCode).toBe(200);
        expect(res.body.color).toBe("red");
        expect(res.body.message).toBe("DON'T WALK!");
    });

    it("green", async () => {
        const res = await request(app)
            .get("/api/trafficlight/green")
            .set("Accept", "application/json");
        expect(res.statusCode).toBe(200);
        expect(res.body.color).toBe("green");
        expect(res.body.message).toBe("WALK!");
    });

    it("orange", async () => {
        const res = await request(app)
            .get("/api/trafficlight/orange")
            .set("Accept", "application/json");
        expect(res.statusCode).toBe(200);
        expect(res.body.color).toBe("orange");
        expect(res.body.message).toBe("ATTENTION!");
    });

    it("unknown color gives 404", async () => {
        const res = await request(app)
            .get("/api/trafficlight/blue")
            .set("Accept", "application/json");
        expect(res.statusCode).toBe(404);
        expect(res.body.message).toBe("Unknown color: blue");
    });
});

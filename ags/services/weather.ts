const logPrefix = "[WeatherService]";
const apiKey = "1648d0002098fdedc4b2071965c077b5";
const absoluteZero = 273.15;

class WeatherService extends Service {
    static {
        Service.register(
            this,
            {
                "weather-poll": ["jsobject"],
            },
            {
                "weather-value": ["jsobject", "r"],
            },
        );
    }
    constructor() {
        super();
        this.#setup();
    }

    get weather_value() {
        return this.#value;
    }

    #value: WeatherValue = {
        icon: "01d",
        description: "loading...",
        temp: 20,
        feelsLike: 20,
    };

    async #setup() {
        const ip = Utils.exec("curl ifconfig.me");

        let locationInfo: undefined | LocationInfo;

        try {
            locationInfo = await Utils.fetch(
                `http://ip-api.com/json/${ip}`,
            ).then((res) => res.json() as unknown as LocationInfo);
        } catch (error) {
            if (error instanceof Error) {
                console.log(
                    `${logPrefix} Error while getting location. ${error.message}`,
                );
            } else {
                console.log(
                    `${logPrefix} Unknown error while getting location. ${JSON.stringify(error)}`,
                );
            }
        }

        if (!locationInfo) return;

        Utils.interval(1800 * 1000, () =>
            this.#poll(locationInfo.lat, locationInfo.lon),
        );
    }

    async #poll(lat: number, lon: number) {
        let weatherInfo: undefined | WeatherInfo;

        try {
            console.log(
                `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}`,
            );
            weatherInfo = await Utils.fetch(
                `https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}`,
            ).then((res) => res.json() as unknown as WeatherInfo);
        } catch (error) {
            if (error instanceof Error) {
                console.log(
                    `${logPrefix} Error while polling weather. ${error.message}`,
                );
            } else {
                console.log(
                    `${logPrefix} Unknown error while polling weather. ${JSON.stringify(error.message)}`,
                );
            }
        }

        if (!weatherInfo) return;

        const value = {
            icon: weatherInfo.weather[0].icon,
            description: weatherInfo.weather[0].description,
            temp: Math.round(weatherInfo.main.temp - absoluteZero),
            feelsLike: Math.round(weatherInfo.main.feels_like - absoluteZero),
        };

        this.#value = value;

        this.notify("weather-value");

        this.emit("weather-poll", value);
    }

    connect(
        event = "weather-poll",
        callback: (_: this, ...args: any[]) => void,
    ) {
        return super.connect(event, callback);
    }
}

type LocationInfo = {
    status: string;
    region: string;
    regionName: string;
    city: string;
    zip: string;
    lat: number;
    lon: number;
    timezone: string;
    isp: string;
    org: string;
    as: string;
    query: string;
};

type WeatherValue = {
    icon: string;
    description: string;
    temp: number;
    feelsLike: number;
};

type WeatherInfo = {
    coord: Coord;
    weather: Weather[];
    base: string;
    main: Main;
    visibility: number;
    wind: Wind;
    clouds: Clouds;
    dt: number;
    sys: Sys;
    timezone: number;
    id: number;
    name: string;
    cod: number;
};

type Coord = {
    lon: number;
    lat: number;
};

type Weather = {
    id: number;
    main: string;
    description: string;
    icon: string;
};

type Main = {
    temp: number;
    feels_like: number;
    temp_min: number;
    temp_max: number;
    pressure: number;
    humidity: number;
    sea_level: number;
    grnd_level: number;
};

type Wind = {
    speed: number;
    deg: number;
    gust: number;
};

type Clouds = {
    all: number;
};

type Sys = {
    country: string;
    sunrise: number;
    sunset: number;
};

export default new WeatherService();

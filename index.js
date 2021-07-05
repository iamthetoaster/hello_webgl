import init, {RenderClient} from './pkg/hello_webgl.js';

const canvas = document.getElementById("rustCanvas");
const gl = canvas.getContext("webgl2", {antialias: true} );

async function start() {
    await init();

    const FPS_THROTTLE = 1000.0 / 30.0
    const initialTime = Date.now();
    let lastDrawTime = initialTime; 


    const client = new RenderClient();

    function frame() {
        window.requestAnimationFrame(frame);
        const currTime = Date.now();

        if (currTime >= lastDrawTime + FPS_THROTTLE) {
            lastDrawTime = currTime;

            // Handle window resizing; to be considered if full screen is desirable 

            if (window.innerHeight !== canvas.height || window.innerWidth !== canvas.width) {

                canvas.height = window.innerHeight;
            //     canvas.clientHeight = window.innerHeight;
                canvas.style.height = window.innerHeight;

                canvas.width = window.innerWidth;
            //     canvas.clientWidth = window.innerWidth;
                console.log(canvas.clientWidth, canvas.clientHeight)
                canvas.style.width = window.innerWidth;

                gl.viewport(0, 0, window.innerWidth, window.innerHeight)
            }

            let elapsedTime = currTime - initialTime;
            client.update(elapsedTime, window.innerHeight, window.innerWidth);
            client.render();
        }
    }
    frame();
}

start()
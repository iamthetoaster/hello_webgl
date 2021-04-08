use wasm_bindgen::prelude::*;
use web_sys::*;
use web_sys::WebGl2RenderingContext as GL;
mod gl_setup;
mod common_funcs;
mod programs;
mod app_state;


#[wasm_bindgen]
extern "C" {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

#[macro_export]
macro_rules! console_log {
    // Note that this is using the `log` function imported above during
    // `bare_bones`
    ($($t:tt)*) => (log(&format_args!($($t)*).to_string()))
}

#[wasm_bindgen]
pub struct RenderClient {
    gl: WebGl2RenderingContext,
    program_color_2d: programs::Color2d,
    program_gradient_2d: programs::Color2dGradient,
}

#[wasm_bindgen]
impl RenderClient {
    #[wasm_bindgen(constructor)]
    pub fn new() -> RenderClient {
        console_error_panic_hook::set_once();
        let gl = gl_setup::initialize_webgl_context().unwrap();
        RenderClient {
            program_color_2d: programs::Color2d::new(&gl),
            program_gradient_2d: programs::Color2dGradient::new(&gl),
            gl: gl,
        }
    }

    pub fn update(&self, time: f32, height: f32, width: f32) -> Result<(), JsValue> {
        app_state::update_dynamic_data(time, height, width);
        Ok(())
    }

    // consider using forward interpolation, passing values into render function
    pub fn render(&self) {
        self.gl.clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT);
        let curr_state = app_state::get_curr_state();
        let border_width = 10.0;
        let measure = curr_state.canvas_width.min(curr_state.canvas_height) - 2.0 * border_width;



        self.program_color_2d.render(
            &self.gl,
            (curr_state.canvas_height - measure) / 2.0,
            (curr_state.canvas_height + measure) / 2.0,
            (curr_state.canvas_width - measure) / 2.0,
            (curr_state.canvas_width + measure) / 2.0,
            curr_state.canvas_width,
            curr_state.canvas_height,
            curr_state.time,
        );

        // let border_width = border_width * 4.0;
        // let measure = curr_state.canvas_width.min(curr_state.canvas_height) - 2.0 * border_width;

        // self.program_gradient_2d.render(
        //     &self.gl,
        //     (curr_state.canvas_height - measure) / 2.0,
        //     (curr_state.canvas_height + measure) / 2.0,
        //     (curr_state.canvas_width - measure) / 2.0,
        //     (curr_state.canvas_width + measure) / 2.0,
        //     curr_state.canvas_width,
        //     curr_state.canvas_height,
        // );
    }

}
use wasm_bindgen::JsCast;
use web_sys::*;
use web_sys::WebGl2RenderingContext as GL;
use js_sys::WebAssembly;
use crate::common_funcs as cf;
// use crate::{log, console_log};

pub struct Color2d {
    program: WebGlProgram,
    rect_vertices_buffer: WebGlBuffer,
    // u_color: WebGlUniformLocation,
    // u_opacity: WebGlUniformLocation,
    // u_frame: WebGlUniformLocation,
    u_transform: WebGlUniformLocation,
    u_size: WebGlUniformLocation,
    rect_vertices_len: usize,
}

impl Color2d {
    pub fn new(gl: &WebGl2RenderingContext) -> Self {
        let program = cf::link_program(
            &gl,
            include_str!("../shaders/vertex/color_2d.hlsl"),
            include_str!("../shaders/fragment/color_2d.hlsl")
        ).unwrap();

        let vertices_rect: [f32; 12] = [
            0., 1.,
            0., 0., 
            1., 1.,
            1., 1.,
            0., 0.,
            1., 0.,
        ];

        let memory_buffer = wasm_bindgen::memory()
            .dyn_into::<WebAssembly::Memory>()
            .unwrap()
            .buffer();
        let vertices_location = vertices_rect.as_ptr() as u32 / 4;
        let vert_array = js_sys::Float32Array::new(&memory_buffer).subarray(
            vertices_location,
            vertices_location + vertices_rect.len() as u32,
        );
        let buffer_rect = gl.create_buffer().ok_or("Failed to create buffer").unwrap();
        gl.bind_buffer(GL::ARRAY_BUFFER, Some(&buffer_rect));

        gl.buffer_data_with_array_buffer_view(GL::ARRAY_BUFFER, &vert_array, GL::STATIC_DRAW);

        Self {
            // u_color: gl.get_uniform_location(&program, "uColor").unwrap(),
            // u_opacity: gl.get_uniform_location(&program, "uOpacity").unwrap(),
            // u_frame: gl.get_uniform_location(&program, "uFrame").unwrap(),
            u_transform: gl.get_uniform_location(&program, "uTransform").unwrap(),
            u_size: gl.get_uniform_location(&program, "uSize").unwrap(),
            program: program,
            rect_vertices_buffer: buffer_rect,
            rect_vertices_len: vertices_rect.len(),
        }
    }

    pub fn render(
        &self,
        gl: &WebGl2RenderingContext,
        bottom: f32,
        top: f32,
        left: f32,
        right: f32,
        canvas_width: f32,
        canvas_height: f32,
    ) {
        gl.use_program(Some(&self.program));

        gl.bind_buffer(GL::ARRAY_BUFFER, Some(&self.rect_vertices_buffer));
        gl.vertex_attrib_pointer_with_i32(0, 2, GL::FLOAT, false, 0, 0);
        gl.enable_vertex_attrib_array(0);
        // gl.uniform4f(
        //     Some(&self.u_color),
        //     0.0,
        //     0.5,
        //     0.5,
        //     1.0,
        // );

        // gl.uniform1f(Some(&self.u_opacity), 1.0);

        // console_log!("Top: {}, Bottom: {}, Left: {} Right: {}, Width: {}, Height: {}", top, bottom, left, right, canvas_width, canvas_height);
        
        gl.uniform1f(Some(&self.u_size), canvas_width);

        let translation_mat = cf::translation_matrix(
            2.0 * left / canvas_width - 1.0,
            2.0 * bottom / canvas_height - 1.0,
            0.0
        );

        let scale_mat = cf::scaling_matrix(
            2.0 * (right - left) / canvas_width,
            2.0 * (top - bottom) / canvas_height,
            1.0,
        );

        let transform_mat = cf::mult_matrix_4(scale_mat, translation_mat);
        gl.uniform_matrix4fv_with_f32_array(Some(&self.u_transform), false, &transform_mat);

        gl.draw_arrays(GL::TRIANGLES, 0, (self.rect_vertices_len / 2) as i32);
    }
}
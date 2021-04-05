/* tslint:disable */
/* eslint-disable */
/**
*/
export class RenderClient {
  free(): void;
/**
*/
  constructor();
/**
* @param {number} time
* @param {number} height
* @param {number} width
*/
  update(time: number, height: number, width: number): void;
/**
*/
  render(): void;
}

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
  readonly memory: WebAssembly.Memory;
  readonly __wbg_renderclient_free: (a: number) => void;
  readonly renderclient_new: () => number;
  readonly renderclient_update: (a: number, b: number, c: number, d: number) => void;
  readonly renderclient_render: (a: number) => void;
  readonly __wbindgen_malloc: (a: number) => number;
  readonly __wbindgen_realloc: (a: number, b: number, c: number) => number;
  readonly __wbindgen_free: (a: number, b: number) => void;
  readonly __wbindgen_exn_store: (a: number) => void;
}

/**
* If `module_or_path` is {RequestInfo} or {URL}, makes a request and
* for everything else, calls `WebAssembly.instantiate` directly.
*
* @param {InitInput | Promise<InitInput>} module_or_path
*
* @returns {Promise<InitOutput>}
*/
export default function init (module_or_path?: InitInput | Promise<InitInput>): Promise<InitOutput>;

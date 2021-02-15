declare global {
  interface Window {
    assetMap: any;
  }
}
let assetMap = window.assetMap;
assetMap = assetMap || {};

function mpath(path: string) {
  if (assetMap[path]) {
    return assetMap[path];
  } else {
    return path;
  }
}
export default mpath;

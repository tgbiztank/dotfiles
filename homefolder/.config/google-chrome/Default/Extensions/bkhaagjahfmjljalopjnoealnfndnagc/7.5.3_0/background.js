(()=>{"use strict";const t=globalThis.chrome&&new function t(e){return new Proxy(e,{get:(e,n)=>"function"!=typeof e[n]?new t(e[n]):(...t)=>new Promise(((o,r)=>{e[n](...t,(t=>{chrome.runtime.lastError?r(new Error(chrome.runtime.lastError.message)):o(t)}))}))})}(globalThis.chrome),e="object"==typeof chrome&&"scripting"in chrome;function n(t){return void 0===t?void 0:[t]}const o=/^(https?|wss?|file|ftp|\*):\/\/(\*|\*\.[^*/]+|[^*/]+)\/.*$|^file:\/\/\/.*$|^resource:\/\/(\*|\*\.[^*/]+|[^*/]+)\/.*$|^about:/,r="object"==typeof navigator&&navigator.userAgent.includes("Firefox/"),i=r?/^(https?|wss?):[/][/][^/]+([/].*)?$/:/^https?:[/][/][^/]+([/].*)?$/,s=/^(https?|file|ftp):[/]+/;function a(...t){return 0===t.length?/$./:t.includes("<all_urls>")?s:t.includes("*://*/*")?i:new RegExp(t.map((t=>function(t){if(!o.test(t))throw new Error(t+" is an invalid pattern, it must match "+String(o));let[,e,n,i]=t.split(/(^[^:]+:[/][/])([^/]+)?/);return e=e.replace("*",r?"(https?|wss?)":"https?").replace(/[/]/g,"[/]"),n=(null!=n?n:"").replace(/^[*][.]/,"([^/]+.)*").replace(/^[*]$/,"[^/]+").replace(/[.]/g,"[.]").replace(/[*]$/g,"[^.]+"),i=i.replace(/[/]/g,"[/]").replace(/[.]/g,"[.]").replace(/[*]/g,".*"),"^"+e+n+"("+i+")?$"}(t))).join("|"))}const c="object"==typeof chrome&&"webNavigation"in chrome;function l(){return function(t){var e,n,o;const r={origins:[],permissions:[]},i=new Set([...null!==(e=t.permissions)&&void 0!==e?e:[],...(null!==(n=t.content_scripts)&&void 0!==n?n:[]).flatMap((t=>{var e;return null!==(e=t.matches)&&void 0!==e?e:[]}))]);t.devtools_page&&!(null===(o=t.optional_permissions)||void 0===o?void 0:o.includes("devtools"))&&i.add("devtools");for(const t of i)t.includes("://")?r.origins.push(t):r.permissions.push(t);return r}(chrome.runtime.getManifest())}const u=/:[/][/][*.]*([^/]+)/;function d(t){return t.split(u)[1]}const m="object"==typeof chrome&&"scripting"in chrome;function f(t){return void 0===t?void 0:[t]}function p({tabId:e,frameId:n,files:o,allFrames:r,matchAboutBlank:i,runAt:s}){for(let a of o)"string"==typeof a&&(a={file:a}),m?chrome.scripting.insertCSS({target:{tabId:e,frameIds:f(n),allFrames:r},files:"file"in a?[a.file]:void 0,css:"code"in a?a.code:void 0}):t.tabs.insertCSS(e,{...a,matchAboutBlank:i,allFrames:r,frameId:n,runAt:null!=s?s:"document_start"})}async function h({tabId:e,frameId:n,files:o,allFrames:r,matchAboutBlank:i,runAt:s}){let a;for(let c of o)if("string"==typeof c&&(c={file:c}),m){if("code"in c)throw new Error("chrome.scripting does not support injecting strings of `code`");chrome.scripting.executeScript({target:{tabId:e,frameIds:f(n),allFrames:r},files:[c.file]})}else"code"in c&&await a,a=t.tabs.executeScript(e,{...c,matchAboutBlank:i,allFrames:r,frameId:n,runAt:s})}async function g(t,e){var n,o,r,i,s,a;const{frameId:c,tabId:l}="object"==typeof t?t:{tabId:t,frameId:0};for(const t of(u=e,Array.isArray(u)?u:[u]))p({tabId:l,frameId:c,files:null!==(n=t.css)&&void 0!==n?n:[],matchAboutBlank:null!==(o=t.matchAboutBlank)&&void 0!==o?o:t.match_about_blank,runAt:null!==(r=t.runAt)&&void 0!==r?r:t.run_at}),h({tabId:l,frameId:c,files:null!==(i=t.js)&&void 0!==i?i:[],matchAboutBlank:null!==(s=t.matchAboutBlank)&&void 0!==s?s:t.match_about_blank,runAt:null!==(a=t.runAt)&&void 0!==a?a:t.run_at});var u;await Promise.all([])}var b,w,y;const v=new Map,I=null!==(y=null===(w=null===(b=null===globalThis||void 0===globalThis?void 0:globalThis.browser)||void 0===b?void 0:b.contentScripts)||void 0===w?void 0:w.register)&&void 0!==y?y:async function(o,r){const{js:i=[],css:s=[],matchAboutBlank:l,matches:u,excludeMatches:d,runAt:m}=o;let{allFrames:f}=o;c?f=!1:f&&console.warn("`allFrames: true` requires the `webNavigation` permission to work correctly: https://github.com/fregante/content-scripts-register-polyfill#permissions");const p=a(...u),h=a(...null!=d?d:[]),g=async(o,r,a=0)=>{p.test(o)&&!h.test(o)&&await async function(e){return t.permissions.contains({origins:[new URL(e).origin+"/*"]})}(o)&&!await async function(n,o){return async function(n,o,...r){const{frameId:i,tabId:s}=function(t){return"object"==typeof t?t:{tabId:t,frameId:0}}(n);if(e){const[t]=await chrome.scripting.executeScript({target:{tabId:s,frameIds:[i]},func:o,args:r});return null==t?void 0:t.result}const[a]=await t.tabs.executeScript(s,{code:`(${o.toString()})(...${JSON.stringify(r)})`,frameId:i});return a}(n,(t=>{const e=document[t];return document[t]=!0,e}),o)}({tabId:r,frameId:a},{js:i,css:s})&&(function({tabId:o,frameId:r,files:i,allFrames:s,matchAboutBlank:a,runAt:c}){for(let l of i)"string"==typeof l&&(l={file:l}),e?chrome.scripting.insertCSS({target:{tabId:o,frameIds:n(r),allFrames:s},files:"file"in l?[l.file]:void 0,css:"code"in l?l.code:void 0}):t.tabs.insertCSS(o,{...l,matchAboutBlank:a,allFrames:s,frameId:r,runAt:null!=c?c:"document_start"})}({tabId:r,frameId:a,files:s,matchAboutBlank:l,runAt:m}),await async function({tabId:o,frameId:r,files:i,allFrames:s,matchAboutBlank:a,runAt:c}){let l;for(let u of i)if("string"==typeof u&&(u={file:u}),e){if("code"in u)throw new Error("chrome.scripting does not support injecting strings of `code`");chrome.scripting.executeScript({target:{tabId:o,frameIds:n(r),allFrames:s},files:[u.file]})}else"code"in u&&await l,l=t.tabs.executeScript(o,{...u,matchAboutBlank:a,allFrames:s,frameId:r,runAt:c})}({tabId:r,frameId:a,files:i,matchAboutBlank:l,runAt:m}))},b=async(t,{status:e},{url:n})=>{e&&n&&g(n,t)},w=async({tabId:t,frameId:e,url:n})=>{g(n,t,e)};c?chrome.webNavigation.onCommitted.addListener(w):chrome.tabs.onUpdated.addListener(b);const y={async unregister(){c?chrome.webNavigation.onCommitted.removeListener(w):chrome.tabs.onUpdated.removeListener(b)}};return"function"==typeof r&&r(y),y};function A(t){return{file:new URL(t,location.origin).pathname}}async function x({origins:t}){const e=chrome.runtime.getManifest().content_scripts;if(!e)throw new Error("webext-dynamic-content-scripts tried to register scripts on th new host permissions, but no content scripts were found in the manifest.");for(const n of t||[])for(const t of e){const e=I({js:(t.js||[]).map((t=>A(t))),css:(t.css||[]).map((t=>A(t))),allFrames:t.all_frames,matches:[n],excludeMatches:t.matches,runAt:t.run_at});v.set(n,e)}var n,o;o=e,0!==(n=t||[]).length&&chrome.tabs.query({url:n},(t=>{for(const e of t)e.id&&g(e.id,o)}))}(async()=>{x(await async function(t){return new Promise((e=>{chrome.permissions.getAll((n=>{const o=l();e(function(t,e,{strictOrigins:n=!0}={}){var o,r;const i={origins:[],permissions:[]};for(const r of null!==(o=e.origins)&&void 0!==o?o:[])if(!t.origins.includes(r)){if(!n){const e=d(r);if(t.origins.some((t=>d(t)===e)))continue}i.origins.push(r)}for(const n of null!==(r=e.permissions)&&void 0!==r?r:[])t.permissions.includes(n)||i.permissions.push(n);return i}(o,n,t))}))}))}({strictOrigins:!1}))})(),chrome.permissions.onAdded.addListener((t=>{t.origins&&t.origins.length>0&&x(t)})),chrome.permissions.onRemoved.addListener((async({origins:t})=>{if(t&&0!==t.length)for(const[e,n]of v)t.includes(e)&&(await n).unregister()}));function k(t){let e;return()=>(void 0!==e||(e=t()),e)}const S=k((()=>globalThis.location?.protocol.startsWith("http"))),_=k((()=>"object"==typeof globalThis.chrome?.extension)),j=(k((()=>_()&&S())),k((()=>_()&&("/_generated_background_page.html"===location.pathname||chrome.extension?.getBackgroundPage?.()===globalThis.window))));async function E(e,n,...o){const{frameId:r,tabId:i}="object"==typeof e?e:{tabId:e,frameId:0},[s]=await t.tabs.executeScript(i,{code:`(${n.toString()})(...${JSON.stringify(o)})`,frameId:r});return s}async function $(e){const{frameId:n,tabId:o}="object"==typeof e?e:{tabId:e,frameId:0};try{if(0===n){const e=await t.tabs.get(o);if(e.url)return e.url}return await E(e,(()=>location.href))}catch{}}k((()=>{if(!_()||!chrome.runtime.getManifest)return!1;const{options_ui:t}=chrome.runtime.getManifest();return"string"==typeof t?.page&&new URL(t.page,location.origin).pathname===location.pathname})),k((()=>{if(!_()||!chrome.devtools)return!1;const{devtools_page:t}=chrome.runtime.getManifest();return"string"==typeof t&&new URL(t,location.origin).pathname===location.pathname}));const B="webext-domain-permission-toggle:add-permission";let M;async function L(e){const n={checked:!1,enabled:!0};if(e){const o=new URL(e).origin,r=a(...l().origins).test(o);n.enabled=!r,n.checked=r||await async function(e){return t.permissions.contains({origins:[e+"/*"]})}(o)}chrome.contextMenus.update(B,n)}async function F({tabId:t}){var e;L(null!==(e=await $(t))&&void 0!==e?e:"")}async function C({checked:e,menuItemId:n},o){if(n===B)try{await async function(e,n){const o="The browser didn't supply any information about the active tab.";if(!e.url&&n)throw new Error(`Please try again. ${o}`);if(!e.url&&!n)throw new Error(`Couldn't disable the extension on the current tab. ${o}`);const r={origins:[new URL(e.url).origin+"/*"]};n?await t.permissions.request(r)?M.reloadOnSuccess&&E(e.id,(t=>{confirm(t)&&location.reload()}),M.reloadOnSuccess):chrome.contextMenus.update(B,{checked:!1}):t.permissions.remove(r)}(o,e)}catch(t){if(null==o?void 0:o.id){try{await E(o.id,"alert",String(t instanceof Error?t:new Error(t.message)))}catch{alert(t)}L()}throw t}}browser.runtime.onMessage.addListener(((t,e,n)=>{if("octotree_send_request"===t.eventName)return async function({method:t,path:e,body:n,token:o},r){try{const i={"Content-Type":"application/json"};o&&(i.Authorization=`Bearer ${o}`);const s=await fetch(`https://www.octotree.io/api/v1.0/${e.replace(/^\//,"")}`,{headers:i,body:n,method:t}),a=s.headers.get("Content-Type");let c;if(c=/application\/json/i.test(a)?await s.json():await s.text(),!s.ok){const t=new Error(c.message||c.statusText||c);throw t.statusCode=s.status,t}r({responseBody:c,responseStatus:s.status})}catch(t){r({message:t.message,statusCode:t.statusCode})}}(t,n),!0;n()})),browser.runtime.setUninstallURL("https://www.octotree.io/feedback"),function(t){if(!j())throw new Error("webext-domain-permission-toggle can only be called from a background page");if(M)throw new Error("webext-domain-permission-toggle can only be initialized once");const{name:e,optional_permissions:n}=chrome.runtime.getManifest();if(M={title:`Enable ${e} on this domain`,reloadOnSuccess:!1},!0===M.reloadOnSuccess&&(M.reloadOnSuccess=`Do you want to reload this page to apply ${e}?`),!chrome.contextMenus)throw new Error("webext-domain-permission-toggle requires the `contextMenu` permission");const o=null==n?void 0:n.filter((t=>/<all_urls>|\*/.test(t)));if(!o||0===o.length)throw new TypeError("webext-domain-permission-toggle some wildcard hosts to be specified in `optional_permissions`");chrome.contextMenus.remove(B,(()=>chrome.runtime.lastError)),chrome.contextMenus.create({id:B,type:"checkbox",checked:!1,title:M.title,contexts:["page_action","browser_action"],documentUrlPatterns:o}),chrome.contextMenus.onClicked.addListener(C),chrome.tabs.onActivated.addListener(F),chrome.tabs.onUpdated.addListener((async(t,{status:e},{url:n,active:o})=>{var r;o&&"complete"===e&&L(null!==(r=null!=n?n:await $(t))&&void 0!==r?r:"")}))}()})();
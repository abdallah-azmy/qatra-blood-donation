'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "2e4400f591d762e605a8dd0905a6fde2",
"version.json": "6ac4d1344e4fe0ab85dd4795922c28de",
"favicon.ico": "c40109139eb819e5b82b2e927ee87b76",
"index.html": "595d8dfd0db3c2185841523b5acd0c83",
"/": "595d8dfd0db3c2185841523b5acd0c83",
"main.dart.js": "d1369f866cab0b10540ba55d5f1bc475",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"firebase_options.json": "6701825317c5945324ccb9258a0412de",
"favicon.png": "c40109139eb819e5b82b2e927ee87b76",
"icons/Icon-192.png": "c40109139eb819e5b82b2e927ee87b76",
"icons/Icon-maskable-192.png": "c40109139eb819e5b82b2e927ee87b76",
"icons/Icon-maskable-512.png": "c40109139eb819e5b82b2e927ee87b76",
"icons/Icon-512.png": "c40109139eb819e5b82b2e927ee87b76",
"manifest.json": "ee4ba4f5e64bba1830b59ce6d4d48f50",
"fainallogo.png": "c40109139eb819e5b82b2e927ee87b76",
".git/config": "f2932f63423727b5f405d1450a38bd27",
".git/objects/92/67227e6fdc8aee9da43a545193609d83a7885d": "a8ee350ca0fab05bae8307cc53d308a0",
".git/objects/9b/3ef5f169177a64f91eafe11e52b58c60db3df2": "91d370e4f73d42e0a622f3e44af9e7b1",
".git/objects/9e/3b4630b3b8461ff43c272714e00bb47942263e": "accf36d08c0545fa02199021e5902d52",
".git/objects/32/3b94f9cecbdaebdc3d802a95a4a3f769e8cd50": "2583af01b821ef06ca663ff15417ef84",
".git/objects/56/2cca64201123f3bff1641927a122bbea416f5e": "41416a5d12022ec47988500a12287c6d",
".git/objects/3d/48f19f9de3d9387b07848c03f5b05597ffcda8": "9c26f049b485b9e301961b3a78d99140",
".git/objects/60/8ae87ca3030fde1b7ee191cfe20932c95a0f17": "556f986236b491325aa46c881cd11490",
".git/objects/60/8bff7900b3e415ba9760b42c1e44c33bdfe727": "8c543be4ac2bb55b6a05565b0e02b8bf",
".git/objects/05/fd44889e3091cc9d8fa9c4bfc4c6073880352c": "2bd4d9e0f52613f36234c36439b6225c",
".git/objects/a4/b0e3d3194254a28dce449f859bb6b3dc80b07e": "389f09f7bb1995f7249780d888acab7e",
".git/objects/a4/9929b877da463c8ef83c832278b7eea43d7730": "5847c2f6c6f064ade8f76b89ba89e1df",
".git/objects/a3/dbc76153248b21119c2d729b1a387260408492": "a36019775a1f34e3138e0397b15997d7",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/da/0d5aa44a8c93eda469f7a99ed8feac32d5b19d": "25d25e93b491abda0b2b909e7485f4d1",
".git/objects/d8/8128adaad90d2fd7cdabe7b36eaaaed0d3a25b": "3d15963af0d77c1cd40702fb7c18fa93",
".git/objects/ab/d5af4b797cfe3dbde4324e7bfcd179ecec98f5": "d1f6c1188de30e5047bf14dfd25cf254",
".git/objects/c9/1c9b5bc8855cd4391c57d8e298d700d5b7c5bd": "a4cd7c052e1ad5f191515e7929bdf55c",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/cf/82c1a45340b155097648acb6623670fad6a285": "676fa6c73d0b575c001eba2fbf7c577a",
".git/objects/ca/3bba02c77c467ef18cffe2d4c857e003ad6d5d": "316e3d817e75cf7b1fd9b0226c088a43",
".git/objects/fe/3b987e61ed346808d9aa023ce3073530ad7426": "dc7db10bf25046b27091222383ede515",
".git/objects/ed/b55d4deb8363b6afa65df71d1f9fd8c7787f22": "886ebb77561ff26a755e09883903891d",
".git/objects/20/3a3ff5cc524ede7e585dff54454bd63a1b0f36": "4b23a88a964550066839c18c1b5c461e",
".git/objects/29/f22f56f0c9903bf90b2a78ef505b36d89a9725": "e85914d97d264694217ae7558d414e81",
".git/objects/29/71fde083957aeae66b979edfe6e56d028d0b4a": "eee29caf660cee4109cdb6e1411da370",
".git/objects/89/c1b55c7371d1b160eb34692b0dd0d2959de5c8": "7dd12fa597467d388d89f942d6dca653",
".git/objects/1f/5946613ed1c6f9e89e3b5dfde5eb8f8bb3ab3e": "f5b952f706afd4be9057797d39fb4af3",
".git/objects/1f/50c780f43c9331804c309e5772e1e0831d18f8": "3be0f2ae8ef27da7f5a81640e3a37af9",
".git/objects/87/6b46b94fb6cb730bfc26eab09a443236c81276": "91c9e92e373148449b8388022e41bf6e",
".git/objects/80/ecf8bf8484fb800c8608a76061a793c38c8723": "a95e4640ec68b225baa14f8aba4d5f76",
".git/objects/17/ff4cda435a25cfeb2efec80b7a30cb74f4c33b": "c03da37867a9d3f0736d6585b3cc7080",
".git/objects/10/7f8c17b65cd5fee28738ce463a5e66e9ea75c8": "825190a6a7ed0c673fd9efca5768a677",
".git/objects/4d/c623963000c9cffcb57a78760c130d83379167": "64fe67c8c805a8383fcf359a754eba2b",
".git/objects/4d/bf9da7bcce5387354fe394985b98ebae39df43": "534c022f4a0845274cbd61ff6c9c9c33",
".git/objects/2a/6c44d9f4c39cb1e23dd41d46d934f3d7836d81": "b07bb0d3e9396f01ed0ff22e1d6990a8",
".git/objects/43/9ccb69409b9edd849ee9035802224a3f57cfa6": "aa75a3569a38210d47abc136e122f515",
".git/objects/6b/f83e9fc77edf33312387ae04052bc5f4c3ca34": "f1dc5239e89e444466c9f18a5c89edd2",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/5d/b986a8331991a60f705b64463b5bf270865846": "bad49041d9d539f3f263703974597575",
".git/objects/62/65e986b829cb75c31b5fdc99ac6f73e74aa6b8": "21746ca1698dad5bfa5882c0f66bf764",
".git/objects/3a/1425e12d2bc033102374d2e29a1acd4190c7b6": "533cf31f8339eaddf27d0f5ff7ca7803",
".git/objects/98/0d49437042d93ffa850a60d02cef584a35a85c": "8e18e4c1b6c83800103ff097cc222444",
".git/objects/37/b34e176c6dd56713046aa70e673454598b2274": "46993f70d9a3942b1f31a5704a5569ee",
".git/objects/08/1ac580c33eda6156085946baee076e1f80f343": "4d4a1b3b386e323fce1182e5f201e555",
".git/objects/52/80aa46545569728273f41770916f03d6a16d9c": "13bf66e385906414a02f7baeca2e02c4",
".git/objects/63/5c1a8c197e90c2da90b5784097456db7a1933d": "b3a6cc3be71402b93bc486f1a65cd72d",
".git/objects/bf/dd33e80b913b053b53bb595e0170712e224d1d": "af5bb80cdef4dd899a29c61342cd4254",
".git/objects/d3/7136238fea252e85ff9a863a4a36c75878c852": "df022ab8440416f9703c5c2fe6b1a459",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/b8/16f6e709a10b2999c50f8a006d46ba7e56e74a": "c89ca0dae16c669881a79040240d0dea",
".git/objects/b6/b8806f5f9d33389d53c2868e6ea1aca7445229": "b14016efdbcda10804235f3a45562bbf",
".git/objects/de/701b2ea2caece477b0e938e3021737f71244cf": "ff954496dca346e6660787d0f6f1d9f5",
".git/objects/c4/016f7d68c0d70816a0c784867168ffa8f419e1": "fdf8b8a8484741e7a3a558ed9d22f21d",
".git/objects/e6/86ef938ec9e41730af3b6bff69185314d4ae2c": "33a6158c479dbbc7aa7721fcb34ff8ee",
".git/objects/e8/e39cd0121235e2fc32dccee571497ffcaeb372": "ccc0d76568873f6ca3612dbc1879c3fd",
".git/objects/c5/276819b27feee382464e271e20bd91955d39f4": "309cffee4111996acecaad46955db024",
".git/objects/c5/abfb2eb847f23a80920833e74fec30e3a7deb3": "80eddcd43cf5fc50eb2a723edd4738b1",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/cb/96f198034092200511411b23b72d7bab609a9f": "bd6155e8bcb4c992815950c3b0da1c81",
".git/objects/70/f6362b70e5abda8cf03859e2e9fcd03ef8c845": "d29ec04913bc3aaad32c7fc9a7c81b07",
".git/objects/4f/fbe6ec4693664cb4ff395edf3d949bd4607391": "2beb9ca6c799e0ff64e0ad79f9e55e69",
".git/objects/7a/6c1911dddaea52e2dbffc15e45e428ec9a9915": "f1dee6885dc6f71f357a8e825bda0286",
".git/objects/25/356e7e851fffc77fe50d0a17af84c300d49915": "3bdceb391b9625074083443efc618553",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "f129c53d1640d2129070cbb0c0fce50e",
".git/logs/refs/heads/gh-pages": "9afe444ec7e0cf5ea738ccd5670f9b67",
".git/logs/refs/remotes/new-origin/gh-pages": "f7d259e6430ee7bf3aa2543073253120",
".git/logs/refs/remotes/origin/gh-pages": "a3ff63859e1eb7e1ff8adaa4c0ea4986",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/gh-pages": "d99a6672fbcfe96cac295fa1685de8a5",
".git/refs/remotes/new-origin/gh-pages": "d99a6672fbcfe96cac295fa1685de8a5",
".git/refs/remotes/origin/gh-pages": "d99a6672fbcfe96cac295fa1685de8a5",
".git/index": "6073aa3ea1befa5af44ff29dcce9b7b5",
".git/COMMIT_EDITMSG": "6292109dcaa061199e334f190b7e6b83",
"assets/AssetManifest.json": "3901d9057bce3eee96e82fa2c19a2ada",
"assets/NOTICES": "c1acc6c232267711817648e45c91f61e",
"assets/FontManifest.json": "005962a00adead3c886d0891db25e2a3",
"assets/AssetManifest.bin.json": "583e41e736f38fc0b6d18899f7bab794",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "a57e31080db3a442d0226feefe568ee7",
"assets/fonts/MaterialIcons-Regular.otf": "f5f03d96947cb630c09f2af966afece7",
"assets/assets/loading.gif": "7fc09f7a20685bfbdccd4d80c9acab59",
"assets/assets/drop.png": "7d0f77132102a5113539d7516f112aa8",
"assets/assets/fainallogo.png": "c40109139eb819e5b82b2e927ee87b76",
"assets/assets/fonts/Tajawal-Bold.ttf": "79bb19e04937c19974260fcb4128270e",
"assets/assets/google.png": "1b943d724cb2d7c49f888f750ce3a479",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

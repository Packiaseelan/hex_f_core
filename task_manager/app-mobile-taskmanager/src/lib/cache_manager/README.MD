# CACHE MANAGER

Cache manager for multiple different types of storage:

**StorageService:**
- SecureStorage
- UnsecureStorage
- MemoryStorage

**FileStorageService**
- FileStorage

## How to use?

Make sure the module you are using has a cache task resolver (extends `CacheTaskResolver`),
and has all the methods implemented.

The module resolver should return said cache task resolver.

You can now use the `TaskManager` to cache information using storage services.

**IMPORTANT** Storage services should always be called via `TaskManager`.
The `Task`'s *apiIdentifier* should be `'local_cache'`.
The *requestData* should have the `CACH_TYPE` and a data map.
The *taskType* should be `TaskType.DATA_CACHE_ONLY`.
The moduleIdentifier should pertain the module being used. For example, the login module *apiIdentifier* is `'app_mobile_login'`.


**Examples** (Using the app_mobile_login module)

Memory Storage Set (String):

`await TaskManager().execute(Task(`
`  apiIdentifier: 'local_cache',`
`  requestData: {`
`    CACHE_TYPE: TaskManagerCacheType.MEMORY_SET,`
`    'data': {key: value}`
`  },`
`  taskType: TaskType.DATA_CACHE_ONLY,`
`  moduleIdentifier: 'app_mobile_login',`
`));`


Memory Storage Get (String):

`final mapData = await TaskManager().execute(Task(`
`  apiIdentifier: 'local_cache',`
`  requestData: {`
`    CACHE_TYPE: TaskManagerCacheType.MEMORY_GET,`
`    'data': {key: null}`
`  },`
`  taskType: TaskType.DATA_CACHE_ONLY,`
`  moduleIdentifier: 'app_mobile_login',`
`)) as Map<String, dynamic?>;`
`final resultValue = mapData[key];`

*Note*: Setting and getting should be the same for the other storage types, just need to change
the requestData `CACHE_TYPE` to the intended type.

// import {get_label} from './list.js'

// export default{
// 	get_label
// }


// 自动导出
const requireApi = require.context(
	'.',
	false,
	/.js$/
)
// console.log(requireApi)
requireApi.keys().forEach((key, index) => {
	if (key === './index.js') return
	Object.assign(module, requireApi(key))
})
export default module

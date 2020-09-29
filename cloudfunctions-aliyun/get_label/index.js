'use strict';
// 获取数据库引用
const db = uniCloud.database()
const $ = db.command.aggregate
exports.main = async (event, context) => {

	// let label = await db.collection('label').get()
	const {
		user_id,
		type
	} = event


	let matchObj = {}
	if (type !== 'all') {
		matchObj = {
			current: true
		}
	}


	// 获取用户表
	let userinfo = await db.collection('user').doc(user_id).get()
	userinfo = userinfo.data[0]

	// label_ids = ['label._id']


	let label = await db.collection('label')
		.aggregate()
		.addFields({
			// 是否在用户表中存在 加个字段 没有的话新增
			current: $.in(['$_id', $.ifNull([userinfo.label_ids, []])])
		})
		.match(matchObj)
		.end()

	//返回数据给客户端
	return {
		code: 200,
		msg: '数据请求成功',
		data: label.data
	}
};

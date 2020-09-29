'use strict';
const db = uniCloud.database()
const $ = db.command.aggregate
exports.main = async (event, context) => {
	//event为客户端上传的参数
	const {
		user_id,
		article_id,

	} = event
	let user = await db.collection('user').doc(user_id).get()
	user = user.data[0]
	let list = await db.collection('article')
		.aggregate()
		.addFields({
			is_author_like: $.in(['$author.id', user.author_likes_ids]),
			is_like: $.in(['$_id', user.article_likes_ids]),
			is_thumbs_up: $.in(['$_id', user.thumbs_up_article_ids])
		})
		.match({
			_id: article_id
		})
		// 不返回
		.project({
			coments: 0
		})
		.end()

	//返回数据给客户端
	return {
		code: 200,
		msg: '数据请求成功',
		data: list.data[0]
	}
};

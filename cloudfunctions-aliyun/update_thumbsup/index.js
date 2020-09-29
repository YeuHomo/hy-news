'use strict';
const db = uniCloud.database()
const dbCmd = db.command
exports.main = async (event, context) => {
	//event为客户端上传的参数
	const {
		user_id,
		article_id
	} = event
	//返回数据给客户端

	const user = await db.collection('user').doc(user_id).get()
	const thumbs_up_article_ids = user.data[0].thumbs_up_article_ids
	let thumbs_ids = null
	if (thumbs_up_article_ids.includes(article_id)) {
		return {
			code: 200,
			msg: '您已点过赞了'
		}
	} else {
		thumbs_ids = dbCmd.addToSet(article_id)
	}

	await db.collection('user').doc(user_id).update({
		thumbs_up_article_ids: thumbs_ids
	})
	await db.collection('article').doc(article_id).update({
		// 次数+1
		thumbs_up_count: dbCmd.inc(1)
	})
	return {
		code: 200,
		msg: '点赞成功'
	}
};

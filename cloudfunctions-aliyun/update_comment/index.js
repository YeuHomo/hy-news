'use strict';
const db = uniCloud.database()
const $ = db.command.aggregate
const dbCmd = db.command

exports.main = async (event, context) => {
	console.log(event)
	const {
		user_id,
		article_id,
		content,
		comment_id = '', // 评论id
		reply_id = '', // 子回复
		is_reply = false
	} = event

	let user = await db.collection('user').doc(user_id).get()
	user = user.data[0]


	// 获取当前文章信息
	const article = await db.collection('article').doc(article_id).get()
	// 获取文章所有评论
	const comments = article.data[0].comments



	let commentObj = {
		comment_id: genID(5), // 评论id
		comment_content: content, // 内容
		create_time: new Date().getTime(), // 创建时间
		is_reply: is_reply,
		author: {
			author_id: user._id,
			author_name: user.author_name,
			avatar: user.avatar,
			professional: user.professional // 专业
		},
		replys: []
	}
	// 评论文章
	if (comment_id === '') {
		commentObj.replys = []
		commentObj = dbCmd.unshift(commentObj)
	} else {
		// 回复评论
		let commentIndex = comments.findIndex(item => item.comment_id === comment_id)

		// 获取作者信息
		let commentAuthor = ''

		if (is_reply) {
			// 子回复
			commentAuthor = comments[commentIndex].replys.find(item=>item.comment_id===reply_id)
		} else {
			// 主回复
			commentAuthor = comments.find(item => item.comment_id === comment_id)
		}
		commentAuthor = commentAuthor.author.author_name
		commentObj.to = commentAuthor
		
		
		// 更新回复信息
		commentObj = {
			[commentIndex]: {
				replys: dbCmd.unshift(commentObj)
			}
		}
	}
	console.log(commentObj)
	await db.collection('article').doc(article_id).update({
		comments: commentObj
	})
	return {
		code: 200,
		msg: '数据更新成功'
	}
};

function genID(length) {
	return Number(Math.random().toString().substr(3, length) + Date.now()).toString(36)
}

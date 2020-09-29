'use strict';
const db = uniCloud.database()

exports.main = async (event, context) => {
	//event为客户端上传的参数
	const {
		user_id = '',
		
	} = event
	
	if(!user_id){
		return {
			code:201,
			msg:'获取用户信息失败'
		}
	}
	
	const userInfo = await db.collection('user').doc(user_id).get()
	
	
	
	
	return {
		code:200,
		msg:'获取成功',
		data:userInfo.data[0]
	}
};

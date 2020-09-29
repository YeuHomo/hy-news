<template>
	<view>
		<uni-popup ref="popup" type="bottom" :maskClick="false">
			<view class="popup-wrap">
				<view class="popup-header">
					<text class="popup-header__item" @click="closeComments">取消</text>
					<text class="popup-header__item" @click="submit">发布</text>
				</view>
				<view class="popup-content">
					<textarea class="popup-textarea" v-model="commentsValue" value="" maxlength="200" fixed placeholder="请输入评论内容" />
					<view class="popup-count">{{commentsValue.length}}/200</view>
				</view>
			</view>
		</uni-popup>
	</view>
</template>

<script>
	export default {
		name:"comments-popup",
		data() {
			return {
				commentsValue:'',
				replyFormData:{}
			};
		},
		props:{
			commentsid:{
				type:String,
				default:''
			}
		},
		methods:{
			closeComments(){
				// 关闭弹窗
				this.$refs.popup.close()
			},
			openComments(){
				console.log('打开')
				this.commentsValue= '';
				this.$refs.popup.open()
			},
			reply(e){
				this.replyFormData={
					"comment_id":e.comments.comment_id,
					"is_reply":e.is_reply
				}
				if(e.comments.reply_id){
					this.replyFormData.reply_id = e.comments.reply_id
				}
				console.log(this.replyFormData)
				this.openComments();
			},
			submit(){
				// 发布
				if(!this.commentsValue){
					uni.showToast({
						title:'请输入评论内容',
						icon:'none'
					})
					return
				}
				// this.setUpdateComment(this.commentsValue)
				this.setUpdateComment({
					content:this.commentsValue,
					...this.replyFormData
				})
			},
			setUpdateComment(content){
				uni.showLoading()
				console.log(content)
				const formdata = {
					article_id:this.commentsid,
					...content
				}
				this.$api.update_comment(formdata).then(res=>{
					uni.hideLoading()
					uni.showToast({
						title:'评论发布成功'
					})
					this.closeComments()
					this.$emit('updateComment')
					this.replyFormData = {}
					this.commentsValue= '';
				})
			},
			
		}
	}
</script>

<style lang="scss">
	.popup-wrap{
		background-color: #fff;
		.popup-header{
			display: flex;
			justify-content: space-between;
			font-size: 14px;
			color: #666;
			border-bottom: 1px #f5f5f5 solid;
			.popup-header__item{
				height: 50px;
				line-height: 50px;
				padding: 0 15px;
			}
		}
		.popup-content{
			width: 100%;
			padding: 15px;
			box-sizing: border-box;
			.popup-textarea{
				width: 100%;
				height: 200px;
				
			}
			.popup-count{
				display: flex;
				justify-content: flex-end;
				font-size: 12px;
				color: #999;
			}
		}
	}

</style>

<template>
	<view>

		<view class="feedback-title">
			意见反馈
		</view>
		<view class="feedback-content">
			<textarea class="feedback-textarea" value="" placeholder="请输入您要反馈的问题" v-model="content" />
			</view>
		<view class="feedback-title">反馈图片：</view>
		<view class="feedback-image-box">
			<view class="feedback-image-item" v-for="(item,index) in imageLists" :key="index">
				<view class="close-icon" @click="del(index)">
					<uni-icons type="closeempty" size="18" color="#fff"></uni-icons>
				</view>
				<view class="image-box">
					<image :src="item.url" mode="aspectFill"></image>
				</view>
			</view>
			<view class="feedback-image-item" @click="addImage" v-if="imageLists.length<5">
				<view class="image-box">
					<uni-icons type="plusempty" size="50" color="#eee"></uni-icons>
				</view>
			</view>
		</view>
		<button type="primary" class="feedback-button" @click="submit">提交</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				imageLists: [],
				content:''
			}
		},
		methods: {
			del(index) {
				this.imageLists.splice(index, 1)
			},
			addImage() {
				let self = this
				const count = 5 - self.imageLists.length

				uni.chooseImage({
					count: count,
					success(res) {
						const tempfilepath = res.tempFiles
						tempfilepath.forEach((item, index) => {
							// h5 count
							if (index < count) {
								self.imageLists.push({
									url: item.path,
									name:item.name
								})
							}
						})
						console.log(res)
					}
				})
			},
			async submit(){
				let imagesPath = []
				uni.showLoading()
				for(let i=0;i<this.imageLists.length;i++){
					// 不支持多图上传
					let filePath = await this.uploadFiles(this.imageLists[i])
					imagesPath.push(filePath)
				}
				
				this.updateFeedback({
					content:this.content,
					feedbackImages:imagesPath
				})
			},
			async uploadFiles(file){
				const result = await uniCloud.uploadFile({
					filePath:file.url,
					cloudPath:file.name
				})
				console.log(result)
				return result.fileID
			},
			updateFeedback({content,feedbackImages}){
				this.$api.update_feedback({content,feedbackImages}).then(res=>{
					uni.hideLoading()
					uni.showToast({
						title:'反馈提交成功',
						icon:'none'
					})
					setTimeout(()=>{
						uni.switchTab({
							url:'/pages/tabbar/my/my'
						})
					},2000)
					
				}).catch(res=>{
					uni.hideLoading()
					uni.showToast({
						title:'反馈提交失败',
						icon:'none'
					})
					
				})
			}
		}
	}
</script>

<style lang="scss">
	.feedback-title {
		font-size: 14px;
		margin: 15px;
		margin-bottom: 0;
		color: #666;
	}

	.feedback-content {
		margin: 15px;
		padding: 10px;
		box-sizing: border-box;
		border: 1px #eee solid;

		.feedback-textarea {
			font-size: 12px;
			// height: 100%;
			width: 100%;

		}
	}

	.feedback-image-box {
		display: flex;
		flex-wrap: wrap;
		padding: 10px;

		.feedback-image-item {
			width: 33.33%;
			position: relative;
			height: 0;
			padding-top: 33.33%;
			box-sizing: border-box;

			.close-icon {
				display: flex;
				align-items: center;
				justify-content: center;
				right: 0;
				position: absolute;
				top: 0;
				width: 22px;
				height: 22px;
				border-radius: 50%;
				background-color: #ff5a5f;
				z-index: 2;

			}

			.image-box {
				display: flex;
				justify-content: center;
				align-items: center;
				position: absolute;
				top: 5px;
				right: 5px;
				bottom: 5px;
				left: 5px;
				border: 1px #eee solid;
				border-radius: 5px;
				overflow: hidden;

				image {
					width: 100%;
					height: 100%;
				}
			}
		}
	}

	.feedback-button {
		margin: 0 15px;
		background-color: $mk-base-color;

	}
</style>

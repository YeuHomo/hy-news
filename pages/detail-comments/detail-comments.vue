<template>
	<view>
		<view class="comments-content" v-for="item in commentsList" :key="item.comment_id">
			<comments-box :comments="item" @reply="reply"></comments-box>
		</view>
		<uni-load-more v-if="commentsList.length===0 || commentsList.length>5" :status="loading" iconType="snow"></uni-load-more>
		<comments-popup ref="commentspopup" :commentsid="article_id" @updateComment="updateComment"></comments-popup>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				article_id: '',
				commentsList: [],
				page: 1,
				pageSize: 5,
				loading: "loading"
			}
		},
		onLoad(query) {
			this.article_id = query.id
			this.getComments()
		},
		onReachBottom() {
			if (this.loading === 'noMore') return
			this.page++
			this.getComments()
			console.log('上拉触底')
		},
		methods: {
			getComments() {
				this.$api.get_comment({
					article_id: this.article_id,
					page: this.page,
					pageSize: this.pageSize
				}).then(res => {
					console.log(res)
					const {
						data
					} = res
					// 对象复制
					if (data.length === 0) {
						this.loading = 'noMore'
						return
					}
					let oldFormData = JSON.parse(JSON.stringify(this.commentsList))
					oldFormData.push(...data)
					this.commentsList = oldFormData

				})
			},
			reply(e) {
				this.$refs.commentspopup.reply(e)
			},
			updateComment() {
				this.commentsList = []
				this.page = 1
				this.loading = "loading"
				this.getComments()
			}
		}
	}
</script>

<style lang="scss">
	.comments-content {
		padding: 0 15px;
	}
</style>

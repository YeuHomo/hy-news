<template>
	<view>
		<uni-load-more v-if="lists.length===0 && loading" iconType="snow" status="loading"></uni-load-more>
		<list-card v-for="item in lists" :key="item.id" :item="item"></list-card>
		<view class="no-data" v-if="lists.length===0 && !loading">没有数据</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				lists: [],
				loading: true
			}
		},
		onLoad() {
			this.getMyArticle()
		},
		methods: {
			getMyArticle() {
				this.$api.get_my_article().then(res => {
					console.log(res)
					const {
						data
					} = res
					this.lists = data
					this.loading = false
				})
			}
		}
	}
</script>

<style>
	.no-data {
		font-size: 14px;
		color: #666;
		padding: 15px 0;
		text-align: center;
	}
</style>

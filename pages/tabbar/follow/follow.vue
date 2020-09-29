<template>
	<view class="follow">
		<view class="follow-tab">
			<view class="follow-tab__box">
				<view class="follow-tab__item" :class="{active:activeIndex===0}" @click="tab(0)">文章</view>
				<view class="follow-tab__item" :class="{active:activeIndex===1}" @click="tab(1)">作者</view>
			</view>
		</view>
		<view class="follow-list">
			<swiper class="follow-list__swiper" :current="activeIndex" @change="change">
				<swiper-item>
					<list-scroll class="list-scroll">
						<uni-load-more v-if="list.length===0 && !articleShow" iconType="snow" status="loading"></uni-load-more>
						<list-card mode="base" v-for="item in list" :key="item._id" :item="item" types="follow"></list-card>
						<view v-if="articleShow" class="no-data">没有收藏文章</view>
					</list-scroll>
				</swiper-item>
				<swiper-item>
					<list-scroll>
						<list-author v-for="item in authorLists" :key="item._id" :item="item"></list-author>
						<view v-if="followShow" class="no-data">没有关注作者</view>
					</list-scroll>
				</swiper-item>
			</swiper>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				activeIndex: 0,
				list: [],
				articleShow: false,
				followShow: false,
				authorLists: []
			}
		},
		onLoad() {
			uni.$on('update_article', () => {
				this.getFollow()
			})
			uni.$on('update_author', () => {
				this.getAuthor()
			})
			this.getFollow()
			this.getAuthor()
		},
		methods: {
			getAuthor() {
				this.$api.get_author().then(res => {
					const {
						data
					} = res
					console.log(data)
					this.authorLists = data
					this.followShow = this.authorLists.length === 0 ? true : false
				})
			},
			change(e) {
				this.activeIndex = e.detail.current
			},
			tab(val) {
				this.activeIndex = val
			},
			getFollow() {
				this.$api.get_follow().then(res => {
					console.log(res)
					const {
						data
					} = res
					this.list = data
					this.articleShow = data.length === 0 ? true : false
				})
			}
		}
	}
</script>

<style lang="scss">
	page {
		height: 100%;
		display: flex;
	}

	.follow {
		// height: 100%;
		display: flex;
		flex-direction: column;
		flex: 1;
		// border: 1px solid red;
		box-sizing: border-box;

		.follow-tab {
			height: 30px;
			padding: 10px 30px;
			border-bottom: 1px #f5f5f5 solid;

			.follow-tab__box {
				width: 100%;
				height: 100%;
				display: flex;
				border-radius: 5px;
				border: 1px $mk-base-color solid;

				.follow-tab__item {
					width: 100%;
					display: flex;
					justify-content: center;
					align-items: center;
					font-size: 14px;
					color: #666;

					&:first-child {
						border-right: 1px $mk-base-color solid;
					}

					&.active {
						color: $mk-base-color;
					}
				}
			}
		}


		.follow-list {
			height: 100%;
			flex: 1;

			// border: 1px red solid;
			.follow-list__swiper {
				height: 100%;

				.swiper-item {
					height: 100%;
				}
			}
		}
	}

	.no-data {
		padding: 50px;
		font-size: 14px;
		color: #999;
		text-align: center;
	}
</style>

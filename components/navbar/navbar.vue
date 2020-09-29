<template>
	<view class="navbar">
		<view class="navbar-fixed">
			<!-- 状态栏 -->
			<!-- #ifndef MP-ALIPAY -->
			<view :style="{height:statusBarHeight+'px'}"></view>
			<!-- #endif -->
			<view class="navbar-content" :style="{height:navBarHeight+'px',width:windowWidth+'px'}" :class="{search:isSearch}"
			 @click="open">
				<!-- 导航内容 -->
				<view class="navbar-content__search-icons" @click="back" v-if="isSearch">
					<uni-icons type="back" size="22" color="#fff"></uni-icons>
				</view>
				<view v-if="!isSearch" class="navbar-search">
					<view class="navbar-search_icon">
						<!-- <text class="iconfont icon-search"></text> -->
						<uni-icons type="search" size="16" color="#999"></uni-icons>
					</view>
					<view class="navbar-search_text">请输入查询内容</view>
				</view>
				<view v-else class="navbar-search">
					<!-- 搜索页显示 -->
					<input class="navbar-search_text" type="text" v-model="val" placeholder="请输入您要搜索的内容" @input="inputChange">
				</view>
			</view>

		</view>

		<view :style="{height:statusBarHeight+navBarHeight +'px'}">

		</view>
	</view>
</template>

<script>
	export default {
		props: {
			value: {
				type: [String, Number],
				default: ''
			},
			isSearch: {
				type: Boolean,
				default: false
			}
		},
		watch: {
			value(newVal) {
				this.val = newVal
			}
		},
		data() {
			return {
				statusBarHeight: 20,
				navBarHeight: 45,
				windowWidth: 375,
				val: null
			}
		},
		created() {
			const info = uni.getSystemInfoSync()
			// 状态栏高度
			console.log(info)
			this.statusBarHeight = info.statusBarHeight
			this.windowWidth = info.windowWidth

			// #ifndef H5 || APP-PLUS || MP-ALIPAY
			// 小程序 获取胶囊位置
			const menuButtonInfo = uni.getMenuButtonBoundingClientRect()
			console.log(menuButtonInfo)
			// 导航栏的高度 
			this.navBarHeight = (menuButtonInfo.bottom - info.statusBarHeight) + (menuButtonInfo.top - info.statusBarHeight)
			// 搜索框宽度
			this.windowWidth = menuButtonInfo.left
			// #endif

			// #ifdef MP-ALIPAY
			this.statusBarHeight = 0
			// #endif


		},
		methods: {
			open() {
				if (this.isSearch) return
				uni.navigateTo({
					url: "/pages/home-search/home-search"
				})
			},
			inputChange(e) {
				const {
					value
				} = e.detail
				this.$emit('input', value)
			},
			back() {
				// uni.navigateBack()
				uni.switchTab({
					url: '/pages/tabbar/index/index'
				})
			}
		}
	}
</script>

<style lang="scss">
	// @import '../../common/css/icons.css';
	.navbar {
		.navbar-fixed {
			position: fixed;
			top: 0;
			left: 0;
			z-index: 99;
			width: 100%;
			background-color: $mk-base-color;

			.navbar-content {
				display: flex;
				justify-content: center;
				align-items: center;
				box-sizing: border-box;
				padding: 0 15px;
				height: 45px;

				.navbar-search {
					display: flex;
					// justify-content: center;
					align-items: center;
					width: 100%;
					padding: 0 10px;
					height: 30px;
					background-color: #FFFFFF;
					border-radius: 30px;

					.navbar-search_icon {
						// width: 10px;
						// height: 10px;
						// border: 1px red solid;
						margin-right: 10px;
					}

					.navbar-search_text {
						font-size: 14px;
						color: #999;
					}
				}

				&.search {
					padding-left: 0;

					.navbar-content__search-icons {
						margin-left: 10px;
						margin-right: 10px;
					}

					.navbar-search {
						border-radius: 5px;
					}
				}
			}
		}
	}
</style>

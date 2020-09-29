<template>
	<view class="tab">
		<scroll-view scroll-x class="tab-scroll">
			<view class="tab-scroll_box">
				<view v-for="(item,index) in list" class="tab-scroll_item" :key="index" :class="{active:activeIndex === index}"
				 @click="clickTab(item,index)">{{item.name}}</view>
			</view>
		</scroll-view>
		<view class="tab-icons" @click="open">
			<uni-icons type="gear" size="16" color="#666666"></uni-icons>
		</view>
	</view>
</template>

<script>
	export default {
		props: {
			list: {
				type: Array,
				default () {
					return []
				}
			},
			tabIndex: {
				type: Number,
				default: 0
			}
		},
		watch: {
			tabIndex(newVal, oldVal) {
				// console.log(newVal, oldVal)
				this.activeIndex = newVal
			}
		},
		data() {
			return {
				activeIndex: 0
			};
		},
		methods: {
			clickTab(item, index) {
				this.activeIndex = index
				this.$emit('tab', {
					data: item,
					index: index
				})
			},
			open(){
				uni.navigateTo({
					url:"/pages/home-label/home-label"
				})
			}
		}
	}
</script>

<style lang="scss">
	.tab {
		display: flex;
		background-color: #ffffff;
		border-bottom: 1px solid #f5f5f5;
		width: 100%;
		box-sizing: border-box;

		.tab-scroll {
			flex: 1;
			overflow: hidden;
			box-sizing: border-box;

			.tab-scroll_box {
				display: flex;
				height: 45px;
				align-items: center;
				flex-wrap: nowrap;
				box-sizing: border-box;

				.tab-scroll_item {
					flex-shrink: 0;
					padding: 10px;
					color: #333;
					font-size: 14px;

					&.active {
						color: $mk-base-color;
					}
				}
			}
		}

		.tab-icons {
			display: flex;
			align-items: center;
			justify-content: center;
			width: 45px;
			position: relative;

			&::after {
				content: "";
				position: absolute;
				top: 12px;
				bottom: 12px;
				left: 0;
				width: 1px;
				background-color: #ddd;
			}
		}
	}
</style>

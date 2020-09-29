<template>
	<view class="label">
		<view class="label-box">
			<view class="label-header">
				<view class="label-title">我的标签</view>
				<view class="label-edit" @click="editLabel">{{is_edit?'完成':'编辑'}}</view>
			</view>
			<uni-load-more status="loading" iconType="snow" v-if="loading"></uni-load-more>
			<view v-if="!loading" class="label-content">
				<view class="label-content__item" v-for="(item,index) in labelList" :key="item._id">
					{{item.name}}
					<uni-icons v-if="is_edit" class="icons-close" type="clear" size="20" color="red" @click="del(index)"></uni-icons>
				</view>
				<view v-if="labelList.length===0" class="no-data">当前没有数据</view>
			</view>
		</view>
		<view class="label-box">
			<view class="label-header">
				<view class="label-title">标签推荐</view>
				<!-- <view class="label-edit">编辑</view> -->
			</view>
			<uni-load-more status="loading" iconType="snow" v-if="loading"></uni-load-more>
			<view v-if="!loading" class="label-content">
				<view class="label-content__item" v-for="(item,index) in list" :key="item._id" @click="add(index)">{{item.name}}</view>
				<view v-if="list.length===0" class="no-data">当前没有数据</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				is_edit: false,
				labelList: [],
				list: [],
				loading: true
			}
		},
		onLoad() {
			// 自定义事件
			
			this.getLabel()
		},
		methods: {
			editLabel() {
				if (this.is_edit) {
					this.setUpdateLabel(this.labelList)
				}
				this.is_edit = !this.is_edit
			},
			getLabel() {
				this.loading = true
				this.$api.get_label({
					type: "all"
				}).then((res) => {

					const {
						data
					} = res
					this.loading = false
					this.labelList = data.filter(item => item.current)
					this.list = data.filter(item => !item.current)
				})
			},
			del(index) {
				this.list.push(this.labelList[index])
				this.labelList.splice(index, 1)
			},
			add(index) {
				if (!this.is_edit) return
				this.labelList.push(this.list[index])
				this.list.splice(index, 1)
			},
			setUpdateLabel(label) {
				const newArrIds = []
				label.forEach(item => {
					newArrIds.push(item._id)
				})
				uni.showLoading()
				this.$api.update_label({
					label: newArrIds
				}).then(res => {
					console.log(res)
					uni.hideLoading()
					uni.showToast({
						title: '更新成功',
						icon: 'none'
					})
					uni.$emit('labelChange')
				})
			}
		}
	}
</script>

<style lang="scss">
	page {
		background-color: #f5f5f5;

	}

	.label {
		.label-box {
			background-color: #ffffff;
			margin-bottom: 10px;

			.label-header {
				display: flex;
				justify-content: space-between;
				font-size: 14px;
				color: #666;
				padding: 10px 15px;
				border-bottom: 1px solid #f5f5f5;

				.label-edit {
					color: #30b33a;
					font-weight: bold;
				}
			}

			.label-content {
				display: flex;
				flex-wrap: wrap;
				padding: 15px;
				padding-top: 0;

				.label-content__item {
					padding: 2px 5px;
					margin-top: 12px;
					margin-right: 10px;
					border: 1px solid #666;
					border-radius: 5px;
					font-size: 14px;
					color: #666;
					position: relative;

					.icons-close {
						position: absolute;
						right: -8px;
						top: -8px;
						background-color: #fff;
						border-radius: 50%;
					}
				}
			}
		}
	}
	.no-data{
		text-align: center;
		width: 100%;
		padding: 50px 0;
		color: #999;
		font-size: 14px;		
	}
</style>

<template>
	<swiper class="home-swiper" @change="change" :current="activeIndex">
		<swiper-item v-for="(item,index) in tab" :key="index">
			<view class="swiper-item">
				<list-item :list="listCatchData[index]" @loadmore="loadmore" :load="load[activeIndex]"></list-item>
			</view>
		</swiper-item>
	</swiper>
</template>

<script>
	import listItem from './list-item.vue'
	export default {
		components: {
			listItem
		},
		props: {
			tab: {
				type: Array,
				default () {
					return []
				}
			},
			activeIndex: {
				type: Number,
				default: 0
			},
		},
		data() {
			return {
				list: [],
				listCatchData: {},
				page: 1,
				pageSize: 10,
				load: {}
			};
		},
		watch: {
			tab(newVal) {
				if (newVal.length === 0) return;
				this.listCatchData = {}
				this.load = {}
				this.getList(this.activeIndex)
			}
		},
		created() {
			// tab未赋值
			// this.getList(0)
			uni.$on('update_article', (e) => {
				if (e === 'follow') {
					this.listCatchData = {}
					this.load = {}
					this.getList(this.activeIndex)
				}
			})
		},
		methods: {
			change(e) {
				const current = e.detail.current
				this.$emit('change', current)
				if (!this.listCatchData[current] || this.listCatchData[current].length === 0) {
					this.getList(current)
				}
			},
			getList(current) {
				if (!this.load[current]) {
					this.load[current] = {
						page: 1,
						loading: 'loading'
					}
				}
				this.$api.get_list({
					name: this.tab[current].name,
					page: this.load[current].page,
					pageSize: this.pageSize
				}).then(res => {
					console.log(res)
					const {
						data
					} = res
					let oldList = this.listCatchData[current] || []
					if (data.length === 0) {
						let oldLoad = {}
						oldLoad.loading = 'noMore'
						oldLoad.page = this.load[current].page
						this.$set(this.load, current, oldLoad)

						//强制渲染页面
						this.$forceUpdate()
						return

					}
					oldList.push(...data)
					this.$set(this.listCatchData, current, oldList)
				})
			},
			loadmore() {

				if (this.load[this.activeIndex].loading !== 'noMore') {
					console.log('上拉')
					this.load[this.activeIndex].page++
					this.getList(this.activeIndex)
				}
			}
		}
	}
</script>

<style lang="scss">
	.home-swiper {
		height: 100%;

		.swiper-item {
			height: 100%;
			overflow: hidden;
		}
	}
</style>

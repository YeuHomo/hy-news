<script>
	export default {
		onLaunch: function() {
			this.$api.get_user({
				user_id: '5f630e450478a80001367900'
			}).then(res => {
				const {
					data
				} = res
				this.$store.dispatch('set_userinfo', data)
			})
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style>
	/*每个页面公共css */
	@import 'components/gaoyia-parse/parse.css'
</style>

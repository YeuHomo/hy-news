<view><view class="my-header"><view class="my-header__background"><image src="{{userInfo.avatar}}" mode="aspectFill"></image></view><view class="my-header__logo"><view class="my-header__logo-box"><image src="{{userInfo.avatar}}" mode="aspectFill"></image></view><text class="my-header__name">{{userInfo.author_name}}</text></view></view><view class="my-header__info"><view class="my-header__info-box"><text class="my-header__info-title">被关注</text><text>{{userInfo.follow_count}}</text></view><view class="my-header__info-box"><text class="my-header__info-title">粉丝</text><text>{{userInfo.fans_count}}</text></view><view class="my-header__info-box"><text class="my-header__info-title">积分</text><text>{{userInfo.integral_count||0}}</text></view></view><view class="my-content"><view data-event-opts="{{[['tap',[['open',['$event']]]]]}}" class="my-content__list" bindtap="__e"><view class="my-content__list-title"><uni-icons class="icons" vue-id="19e19b7e-1" type="contact" size="16" color="#666" bind:__l="__l"></uni-icons><text>我的文章</text></view><uni-icons vue-id="19e19b7e-2" type="arrowright" size="14" color="#666" bind:__l="__l"></uni-icons></view><view data-event-opts="{{[['tap',[['feedback',['$event']]]]]}}" class="my-content__list" bindtap="__e"><view class="my-content__list-title"><uni-icons class="icons" vue-id="19e19b7e-3" type="help" size="16" color="#666" bind:__l="__l"></uni-icons><text>意见反馈</text></view><uni-icons vue-id="19e19b7e-4" type="arrowright" size="14" color="#666" bind:__l="__l"></uni-icons></view></view></view>
<view data-event-opts="{{[['tap',[['open',['$event']]]]]}}" bindtap="__e"><block qq:if="{{item.mode==='base'}}"><view class="listcard"><view class="listcard-image"><image src="{{item.cover[0]}}" mode="aspectFill"></image></view><view class="listcard-content"><view class="listcard-content__title"><text>{{item.title}}</text><likes vue-id="cb745ce4-1" item="{{item}}" types="{{types}}" bind:__l="__l"></likes></view><view class="listcard-content_des"><view class="listcard-content_des-label"><view class="listcard-content_des-label-item">{{item.classify}}</view></view><view class="listcard-content_des-browse">{{item.browse_count+"浏览"}}</view></view></view></view></block><block qq:if="{{item.mode==='column'}}"><view class="listcard moda-column"><view class="listcard-content"><view class="listcard-content__title"><text>{{item.title}}</text><likes vue-id="cb745ce4-2" item="{{item}}" types="{{types}}" bind:__l="__l"></likes></view><view class="listcard-image"><block qq:for="{{item.cover}}" qq:for-item="it" qq:for-index="index" qq:key="*this"><block qq:if="{{index<3}}"><view class="listcard-image__item"><image src="{{it}}" mode="aspectFill"></image></view></block></block></view><view class="listcard-content_des"><view class="listcard-content_des-label"><view class="listcard-content_des-label-item">{{item.classify}}</view></view><view class="listcard-content_des-browse">{{item.browse_count+"浏览"}}</view></view></view></view></block><block qq:if="{{item.mode==='image'}}"><view class="listcard moda-image"><view class="listcard-image"><image src="{{item.cover[0]}}" mode="aspectFill"></image></view><view class="listcard-content"><view class="listcard-content__title"><text>{{item.title}}</text><likes vue-id="cb745ce4-3" item="{{item}}" types="{{types}}" bind:__l="__l"></likes></view><view class="listcard-content_des"><view class="listcard-content_des-label"><view class="listcard-content_des-label-item">{{item.classify}}</view></view><view class="listcard-content_des-browse">{{item.browse_count+"浏览"}}</view></view></view></view></block></view>
<view class="label"><view class="label-box"><view class="label-header"><view class="label-title">我的标签</view><view data-event-opts="{{[['tap',[['editLabel',['$event']]]]]}}" class="label-edit" bindtap="__e">{{is_edit?'完成':'编辑'}}</view></view><block qq:if="{{loading}}"><uni-load-more vue-id="8e5a6860-1" status="loading" iconType="snow" bind:__l="__l"></uni-load-more></block><block qq:if="{{!loading}}"><view class="label-content"><block qq:for="{{labelList}}" qq:for-item="item" qq:for-index="index" qq:key="_id"><view class="label-content__item">{{''+item.name+''}}<block qq:if="{{is_edit}}"><uni-icons class="icons-close" vue-id="{{'8e5a6860-2-'+index}}" type="clear" size="20" color="red" data-event-opts="{{[['^click',[['del',[index]]]]]}}" bind:click="__e" bind:__l="__l"></uni-icons></block></view></block><block qq:if="{{labelList.length===0}}"><view class="no-data">当前没有数据</view></block></view></block></view><view class="label-box"><view class="label-header"><view class="label-title">标签推荐</view></view><block qq:if="{{loading}}"><uni-load-more vue-id="8e5a6860-3" status="loading" iconType="snow" bind:__l="__l"></uni-load-more></block><block qq:if="{{!loading}}"><view class="label-content"><block qq:for="{{list}}" qq:for-item="item" qq:for-index="index" qq:key="_id"><view data-event-opts="{{[['tap',[['add',[index]]]]]}}" class="label-content__item" bindtap="__e">{{item.name}}</view></block><block qq:if="{{list.length===0}}"><view class="no-data">当前没有数据</view></block></view></block></view></view>
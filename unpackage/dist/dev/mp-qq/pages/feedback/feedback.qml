<view><view class="feedback-title">意见反馈</view><view class="feedback-content"><textarea class="feedback-textarea" value="{{content}}" placeholder="请输入您要反馈的问题" data-event-opts="{{[['input',[['__set_model',['','content','$event',[]]]]]]}}" bindinput="__e"></textarea></view><view class="feedback-title">反馈图片：</view><view class="feedback-image-box"><block qq:for="{{imageLists}}" qq:for-item="item" qq:for-index="index" qq:key="index"><view class="feedback-image-item"><view data-event-opts="{{[['tap',[['del',[index]]]]]}}" class="close-icon" bindtap="__e"><uni-icons vue-id="{{'91bbcf20-1-'+index}}" type="closeempty" size="18" color="#fff" bind:__l="__l"></uni-icons></view><view class="image-box"><image src="{{item.url}}" mode="aspectFill"></image></view></view></block><block qq:if="{{imageLists.length<5}}"><view data-event-opts="{{[['tap',[['addImage',['$event']]]]]}}" class="feedback-image-item" bindtap="__e"><view class="image-box"><uni-icons vue-id="91bbcf20-2" type="plusempty" size="50" color="#eee" bind:__l="__l"></uni-icons></view></view></block></view><button class="feedback-button" type="primary" data-event-opts="{{[['tap',[['submit',['$event']]]]]}}" bindtap="__e">提交</button></view>
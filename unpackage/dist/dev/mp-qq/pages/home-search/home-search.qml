<view class="home"><navbar vue-id="88a68104-1" isSearch="{{true}}" value="{{value}}" data-event-opts="{{[['^input',[['__set_model',['','value','$event',[]]],['change']]]]}}" bind:input="__e" bind:__l="__l"></navbar><view class="home-list"><block qq:if="{{is_history}}"><view class="label-box"><view class="label-header"><text class="label-title">搜索历史</text><text data-event-opts="{{[['tap',[['clearHistory',['$event']]]]]}}" class="label-clear" bindtap="__e">清空</text></view><block qq:if="{{historyLists.length>0}}"><view class="label-content"><block qq:for="{{historyLists}}" qq:for-item="item" qq:for-index="__i0__" qq:key="id"><view data-event-opts="{{[['tap',[['openHistory',['$0'],[[['historyLists','id',item.id]]]]]]]}}" class="label-content__item" bindtap="__e">{{item.name}}</view></block></view></block><block qq:else><view class="no-data">没有搜索历史</view></block></view></block><block qq:else><list-scroll class="list-scroll" vue-id="88a68104-2" bind:__l="__l" vue-slots="{{['default']}}"><block qq:if="{{loading}}"><uni-load-more vue-id="{{('88a68104-3')+','+('88a68104-2')}}" status="loading" iconType="snow" bind:__l="__l"></uni-load-more></block><block qq:if="{{searchList.length>0}}"><view><block qq:for="{{searchList}}" qq:for-item="item" qq:for-index="__i1__" qq:key="_id"><list-card vue-id="{{('88a68104-4-'+__i1__)+','+('88a68104-2')}}" mode="base" item="{{item}}" data-event-opts="{{[['^saveHistory',[['setHistory']]]]}}" bind:saveHistory="__e" bind:__l="__l"></list-card></block></view></block><block qq:if="{{searchList.length===0&&!loading}}"><view class="no-data">没有搜索到相关数据</view></block></list-scroll></block></view></view>
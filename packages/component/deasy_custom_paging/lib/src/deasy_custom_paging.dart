import 'dart:async';

import 'package:flutter/material.dart';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

typedef Future<bool> FutureCallBack();

class DeasyCustomPaging extends StatefulWidget {
  static DelegateBuilder<LoadMoreDelegate> buildDelegate =
      () => DefaultLoadMoreDelegate();
  static DelegateBuilder<LoadMoreTextBuilder> buildTextBuilder =
      () => DefaultLoadMoreTextBuilder.indonesia;

  final Widget child;

  final FutureCallBack onLoadMore;

  final bool isFinish;

  final LoadMoreDelegate? delegate;

  final LoadMoreTextBuilder? textBuilder;

  final bool whenEmptyLoad;

  const DeasyCustomPaging({
    Key? key,
    required this.child,
    required this.onLoadMore,
    this.textBuilder,
    this.isFinish = false,
    this.delegate,
    this.whenEmptyLoad = true,
  }) : super(key: key);

  @override
  _CustomPagingState createState() => _CustomPagingState();
}

class _CustomPagingState extends State<DeasyCustomPaging> {
  Widget get child => widget.child;

  LoadMoreDelegate get loadMoreDelegate =>
      widget.delegate ?? DeasyCustomPaging.buildDelegate();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (child is ListView) {
      return _buildListView(child as ListView);
    }
    if (child is SliverList) {
      return _buildSliverList(child as SliverList);
    }
    return child;
  }

  Widget _buildListView(ListView listView) {
    var delegate = listView.childrenDelegate;
    outer:
    if (delegate is SliverChildBuilderDelegate) {
      SliverChildBuilderDelegate delegate =
          listView.childrenDelegate as SliverChildBuilderDelegate;
      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }
      var viewCount = (delegate.estimatedChildCount ?? 0) + 1;
      IndexedWidgetBuilder builder = (context, index) {
        if (index == viewCount - 1) {
          return _buildLoadMoreView();
        }
        return delegate.builder(context, index) ?? Container();
      };

      return ListView.builder(
        itemBuilder: builder,
        addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
        addRepaintBoundaries: delegate.addRepaintBoundaries,
        addSemanticIndexes: delegate.addSemanticIndexes,
        dragStartBehavior: listView.dragStartBehavior,
        semanticChildCount: listView.semanticChildCount,
        itemCount: viewCount,
        cacheExtent: listView.cacheExtent,
        controller: listView.controller,
        itemExtent: listView.itemExtent,
        key: listView.key,
        padding: listView.padding,
        physics: listView.physics,
        primary: listView.primary,
        reverse: listView.reverse,
        scrollDirection: listView.scrollDirection,
        shrinkWrap: listView.shrinkWrap,
      );
    } else if (delegate is SliverChildListDelegate) {
      SliverChildListDelegate delegate =
          listView.childrenDelegate as SliverChildListDelegate;

      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }

      delegate.children.add(_buildLoadMoreView());
      return ListView(
        children: delegate.children,
        addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
        addRepaintBoundaries: delegate.addRepaintBoundaries,
        cacheExtent: listView.cacheExtent,
        controller: listView.controller,
        itemExtent: listView.itemExtent,
        key: listView.key,
        padding: listView.padding,
        physics: listView.physics,
        primary: listView.primary,
        reverse: listView.reverse,
        scrollDirection: listView.scrollDirection,
        shrinkWrap: listView.shrinkWrap,
        addSemanticIndexes: delegate.addSemanticIndexes,
        dragStartBehavior: listView.dragStartBehavior,
        semanticChildCount: listView.semanticChildCount,
      );
    }
    return listView;
  }

  Widget _buildSliverList(SliverList list) {
    final delegate = list.delegate;

    if (delegate is SliverChildListDelegate) {
      return SliverList(
        delegate: delegate,
      );
    }

    outer:
    if (delegate is SliverChildBuilderDelegate) {
      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }
      final viewCount = (delegate.estimatedChildCount ?? 0) + 1;
      IndexedWidgetBuilder builder = (context, index) {
        if (index == viewCount - 1) {
          return _buildLoadMoreView();
        }
        return delegate.builder(context, index) ?? Container();
      };

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          builder,
          addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
          addRepaintBoundaries: delegate.addRepaintBoundaries,
          addSemanticIndexes: delegate.addSemanticIndexes,
          childCount: viewCount,
          semanticIndexCallback: delegate.semanticIndexCallback,
          semanticIndexOffset: delegate.semanticIndexOffset,
        ),
      );
    }

    outer:
    if (delegate is SliverChildListDelegate) {
      if (!widget.whenEmptyLoad && delegate.estimatedChildCount == 0) {
        break outer;
      }
      delegate.children.add(_buildLoadMoreView());
      return SliverList(
        delegate: SliverChildListDelegate(
          delegate.children,
          addAutomaticKeepAlives: delegate.addAutomaticKeepAlives,
          addRepaintBoundaries: delegate.addRepaintBoundaries,
          addSemanticIndexes: delegate.addSemanticIndexes,
          semanticIndexCallback: delegate.semanticIndexCallback,
          semanticIndexOffset: delegate.semanticIndexOffset,
        ),
      );
    }

    return list;
  }

  LoadMoreStatus status = LoadMoreStatus.idle;

  Widget _buildLoadMoreView() {
    if (widget.isFinish == true) {
      this.status = LoadMoreStatus.noMore;
    } else {
      if (this.status == LoadMoreStatus.noMore) {
        this.status = LoadMoreStatus.idle;
      }
    }
    return NotificationListener<_RetryNotify>(
      child: NotificationListener<_BuildNotify>(
        child: DefaultLoadMoreView(
          status: status,
          delegate: loadMoreDelegate,
          textBuilder: widget.textBuilder ?? DeasyCustomPaging.buildTextBuilder(),
        ),
        onNotification: _onLoadMoreBuild,
      ),
      onNotification: _onRetry,
    );
  }

  bool _onLoadMoreBuild(_BuildNotify notification) {
    if (status == LoadMoreStatus.loading) {
      return false;
    }
    if (status == LoadMoreStatus.noMore) {
      return false;
    }
    if (status == LoadMoreStatus.fail) {
      return false;
    }
    if (status == LoadMoreStatus.idle) {
      loadMore();
    }
    return false;
  }

  void _updateStatus(LoadMoreStatus status) {
    if (mounted) setState(() => this.status = status);
  }

  bool _onRetry(_RetryNotify notification) {
    loadMore();
    return false;
  }

  void loadMore() {
    _updateStatus(LoadMoreStatus.loading);
    widget.onLoadMore().then((v) {
      if (v == true) {
        _updateStatus(LoadMoreStatus.idle);
      } else {
        _updateStatus(LoadMoreStatus.fail);
      }
    });
  }
}

enum LoadMoreStatus {
  idle,
  loading,
  fail,
  noMore,
}

class DefaultLoadMoreView extends StatefulWidget {
  final LoadMoreStatus status;
  final LoadMoreDelegate delegate;
  final LoadMoreTextBuilder textBuilder;

  const DefaultLoadMoreView({
    Key? key,
    this.status = LoadMoreStatus.idle,
    required this.delegate,
    required this.textBuilder,
  }) : super(key: key);

  @override
  DefaultLoadMoreViewState createState() => DefaultLoadMoreViewState();
}

const _defaultLoadMoreHeight = 80.0;
const _loadmoreIndicatorSize = 33.0;
const _loadMoreDelay = 16;

class DefaultLoadMoreViewState extends State<DefaultLoadMoreView> {
  LoadMoreDelegate get delegate => widget.delegate;

  @override
  Widget build(BuildContext context) {
    notify();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (widget.status == LoadMoreStatus.fail ||
            widget.status == LoadMoreStatus.idle) {
          _RetryNotify().dispatch(context);
        }
      },
      child: Container(
        height: delegate.widgetHeight(widget.status),
        alignment: Alignment.center,
        child: delegate.buildChild(
          widget.status,
          builder: widget.textBuilder,
        ),
      ),
    );
  }

  void notify() async {
    var delay = max(delegate.loadMoreDelay(), Duration(milliseconds: 16));
    await Future.delayed(delay);
    if (widget.status == LoadMoreStatus.idle) {
      _BuildNotify().dispatch(context);
    }
  }

  Duration max(Duration duration, Duration duration2) {
    if (duration > duration2) {
      return duration;
    }
    return duration2;
  }
}

class _BuildNotify extends Notification {}

class _RetryNotify extends Notification {}

typedef T DelegateBuilder<T>();

abstract class LoadMoreDelegate {
  static DelegateBuilder<LoadMoreDelegate> buildWidget =
      () => DefaultLoadMoreDelegate();

  const LoadMoreDelegate();

  double widgetHeight(LoadMoreStatus status) => _defaultLoadMoreHeight;

  Duration loadMoreDelay() => Duration(milliseconds: _loadMoreDelay);

  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.indonesia});
}

class DefaultLoadMoreDelegate extends LoadMoreDelegate {
  const DefaultLoadMoreDelegate();

  @override
  Widget buildChild(LoadMoreStatus status,
      {LoadMoreTextBuilder builder = DefaultLoadMoreTextBuilder.indonesia}) {
    String text = builder(status);
    if (status == LoadMoreStatus.fail) {
      return Container(
        child: Text(text),
      );
    }
    if (status == LoadMoreStatus.idle) {
      return Text(text);
    }
    if (status == LoadMoreStatus.loading) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: _loadmoreIndicatorSize,
              height: _loadmoreIndicatorSize,
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ],
        ),
      );
    }
    if (status == LoadMoreStatus.noMore) {
      return Text(text);
    }

    return Text(text);
  }
}

typedef String LoadMoreTextBuilder(LoadMoreStatus status);

String _buildEnglishText(LoadMoreStatus status) {
  String text;
  switch (status) {
    case LoadMoreStatus.fail:
      text = "load fail, tap to retry";
      break;
    case LoadMoreStatus.idle:
      text = "wait for loading";
      break;
    case LoadMoreStatus.loading:
      text = "loading";
      break;
    default:
      text = "";
  }
  return text;
}

String _buildIndonesiaText(LoadMoreStatus status) {
  String text;
  switch (status) {
    case LoadMoreStatus.fail:
      text = "gagal load, coba lagi";
      break;
    case LoadMoreStatus.idle:
      text = "sedang memuat data";
      break;
    case LoadMoreStatus.loading:
      text = "loading";
      break;
    default:
      text = "";
  }
  return text;
}

class DefaultLoadMoreTextBuilder {
  static const LoadMoreTextBuilder indonesia = _buildIndonesiaText;

  static const LoadMoreTextBuilder english = _buildEnglishText;
}

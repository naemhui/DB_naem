from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

from .models import Article, Comment
from .forms import ArticleForm, CommentForm


# Create your views here.
def index(request):
    articles = Article.objects.all()
    context = {
        'articles': articles,
    }
    return render(request, 'articles/index.html', context)


def detail(request, pk):
    article = Article.objects.get(pk=pk)
    comment_form = CommentForm()
    # 해당 게시글에 작성된 모든 댓글 조회 (역참조)
    comments = article.comment_set.all()  # 댓글 목록들

    context = {
        'article': article,
        'comment_form' : comment_form,
        'comments' : comments,
    }
    return render(request, 'articles/detail.html', context)


@login_required
def create(request):
    if request.method == 'POST':
        form = ArticleForm(request.POST)
        if form.is_valid():
            article = form.save()
            return redirect('articles:detail', article.pk)
    else:
        form = ArticleForm()
    context = {
        'form': form,
    }
    return render(request, 'articles/create.html', context)


@login_required
def update(request, pk):
    article = Article.objects.get(pk=pk)
    if request.method == 'POST':
        form = ArticleForm(request.POST, instance=article)
        if form.is_valid():
            form.save()
            return redirect('articles:detail', article.pk)
    else:
        form = ArticleForm(instance=article)
    context = {
        'article': article,
        'form': form,
    }
    return render(request, 'articles/update.html', context)


@login_required
def delete(request, pk):
    article = Article.objects.get(pk=pk)
    article.delete()
    return redirect('articles:index')


def comments_create(request, pk):
    # 애초에 GET요청이 올 일이 없기 때문에 다음과 같은 구조 필요 없음
    # if request.method == 'POST':
    #    pass
    # else:
    #    pass

    # 어떤 게시글에 작성되는지 게시글 조회
    article = Article.objects.get(pk=pk)
    comment_form = CommentForm(request.POST)
    if comment_form.is_valid():
        # 외래 키 데이터 넣는 타이밍 필요
        # 외래 키 넣기 위한 2가지 조건
        # 1. comment 인스턴스 필요 (comment.instance 해야되니까)
        # 2. save() 메서드가 호출되기 전이어야 함
        # 근데 현재 문제: comment 인스턴스는 save 메서드가 호출되어야 생성됨
        # 그래서 django의 save 메서드는 인스턴스만 제공하고, 실제 저장은 잠시 대기하는 옵션을 제공함
        comment = comment_form.save(commit=False)  # 이렇게 해놓으면 save가 인스턴스만 반환(DB에 저장 요청X)
        comment.article = article
        comment.save()
        return redirect('articles:detail', article.pk)  # 댓글이 detail 페이지에 이씀
    context = {
        'article' : article,
        'comment_form' : comment_form, 
    }
    return render(request, 'articles/detail.html', context)  # 이렇게 해야 에러 메시지를 포함한 detail 페이지 render

def comments_delete(request, article_pk, comment_pk):
    # 어떤 댓글을 삭제할지 조회
    comment = Comment.objects.get(pk=comment_pk)
    # 방법1. 삭제되기 전에 저 인스턴트 살아있을 때 변수에 담기
    # article_pk = comment.article.pk
    # 방법2. detail에 article pk를 남기는 두 번째 방법
    article = Article.objects.get(pk=article_pk)

    comment.delete()
    # return redirect('articles:detail', 삭제되는 댓글의 게시글 pk)
    return redirect('articles:detail', article.pk)
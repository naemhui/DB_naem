from django.db import models


# Create your models here.
class Article(models.Model):
    title = models.CharField(max_length=10)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Comment(models.Model):
    # 외래키는 보통 참조해야 하는 모델의 단수형
    # ForeignKey(상대 모델 클래스, 상대 모델 클래스가 삭제되었을 때 댓글을 어떻게 처리할지)
    article = models.ForeignKey(Article, on_delete=models.CASCADE)  # Article 지워졌을 때 속성값(댓글 등) 지우겠다0
    content = models.CharField(max_length=200)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
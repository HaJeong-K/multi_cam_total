from django.shortcuts import render
from django.http import HttpResponse

from django.core.mail import send_mail
from django.conf import settings

# Create your views here.
def index(request, ):
    if request.method == "POST":
        message = request.POST['message']
        email = request.POST['email']
        name = request.POST['name']
        send_mail(
            name, 
            message, # 메시지
            'settings.EMAIL_HOST_USER', 
            [email]
        )
    return render(request, 'main/index.html')
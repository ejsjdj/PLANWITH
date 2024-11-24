<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    .footer-container {
        background-color: #2c3e50;
        color: #ecf0f1;
        font-family: 'Noto Sans KR', sans-serif;
        padding: 30px 0;
    }
    
    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }
    
    .footer-main {
        margin-bottom: 20px;
    }
    
    .contact-cards {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        gap: 15px;
    }
    
    .contact-card {
        background-color: #34495e;
        border-radius: 8px;
        padding: 12px;
        width: calc(20% - 12px);
        box-sizing: border-box;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .contact-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    .contact-card h3 {
        font-size: 15px;
        margin: 0 0 5px;
        color: #3498db;
    }
    
    .contact-card p {
        font-size: 13px;
        margin: 0;
        color: #bdc3c7;
    }
    
    .footer-info {
        border-top: 1px solid #34495e;
        padding-top: 15px;
        text-align: center;
    }
    
    .footer-info p {
        color: #95a5a6;
        font-size: 13px;
        margin: 5px 0;
    }
</style>

<footer class="footer-container">
    <div class="footer-content">
        <div class="footer-main">
            <div class="contact-cards">
                <div class="contact-card">
                    <h3>김기범</h3>
                    <p>시스템 아키텍쳐, 지도 계획수립 기능 개발</p>
                    <p>ejsjdj@gmail.com</p>
                </div>
                <div class="contact-card">
                    <h3>문서희</h3>
                    <p>코드 종합, 리뷰, 백엔드 부분 총괄, 친구관리 부분 개발</p>
                    <p>moondal366@gmail.com</p>
                </div>
                <div class="contact-card">
                    <h3>김혜환</h3>
                    <p>로그인, 로그아웃, 회원정보수정관리, 네이버 카카오 OAuth 개발</p>
                    <p>khh5327@naver.com</p>
                </div>
                <div class="contact-card">
                    <h3>김규리</h3>
                    <p>Stomp 이용한 실시간 작업처리 부분 개발, 프론트앤드 디자인 총괄</p>
                    <p>alsgk2000@gmail.com</p>
                </div>
                <div class="contact-card">
                    <h3>황성재</h3>
                    <p>게시판, 댓글 대댓글 태그 컨셉디자인, 프론트엔드 기능</p>
                    <p>hsj12141@naver.com</p>
                </div>
            </div>
        </div>
        <div class="footer-info">
            <p>PLANWITH - 여행을 더 즐겁게, 계획을 더 쉽게</p>
            <p>실시간 채팅과 지도 기반 여행 계획 플랫폼</p>
            <p>&copy; 2024 PLANWITH. All rights Reserved.</p>
        </div>
    </div>
</footer>
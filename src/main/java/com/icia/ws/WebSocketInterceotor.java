package com.icia.ws;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class WebSocketInterceotor extends HttpSessionHandshakeInterceptor{

	@Override
	public boolean beforeHandshake(org.springframework.http.server.ServerHttpRequest request,
			org.springframework.http.server.ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
		HttpServletRequest req = ssreq.getServletRequest();
		SecurityContext context = (SecurityContext)req.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
		attributes.put("username", context.getAuthentication().getName());
		return super.beforeHandshake(request, response, wsHandler, attributes);
	}
	
	
	
	
}

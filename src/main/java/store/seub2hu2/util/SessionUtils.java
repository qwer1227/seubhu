package store.seub2hu2.util;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.util.Objects;

public class SessionUtils {

    /**
     * 세션에 속성 추가
     *
     * @param name 속성 이름
     * @param value 속성 값
     */
    public static void addAttribute(String name, Object value) {
        Objects.requireNonNull(RequestContextHolder.getRequestAttributes())
                .setAttribute(name, value, RequestAttributes.SCOPE_SESSION);
    }

    /**
     * 세션에서 문자열 속성 값을 가져오기
     *
     * @param name 속성 이름
     * @return 문자열 값
     */
    public static String getStringAttributeValue(String name) {
        return String.valueOf(getAttribute(name));
    }

    /**
     * 세션에서 속성 값을 가져오기
     *
     * @param name 속성 이름
     * @return 속성 값
     */
    public static Object getAttribute(String name) {
        return Objects.requireNonNull(RequestContextHolder.getRequestAttributes())
                .getAttribute(name, RequestAttributes.SCOPE_SESSION);
    }

    /**
     * 세션에서 속성 제거
     *
     * @param name 속성 이름
     */
    public static void removeAttribute(String name) {
        Objects.requireNonNull(RequestContextHolder.getRequestAttributes())
                .removeAttribute(name, RequestAttributes.SCOPE_SESSION);
    }
}

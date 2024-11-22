package store.seub2hu2.security.oauth.info;

import java.util.Map;

public class NaverOAuth2UserInfo extends OAuth2UserInfo {

    public NaverOAuth2UserInfo(Map<String, Object> attributes) {
        super(attributes);
    }

    @Override
    public String getId() {
        Map<String, Object> attributes = (Map<String, Object>) getAttributes().get("response");
        if (attributes == null) {
            return null;
        }
        return (String) getAttributes().get("id");
    }


    @Override
    public String getName() {
        return (String) getAttributes().get("name");
    }

    @Override
    public String getEmail() {
        return (String) getAttributes().get("email");
    }

}
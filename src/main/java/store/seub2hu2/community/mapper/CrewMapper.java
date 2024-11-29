package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Crew;

import java.util.List;
import java.util.Map;

public interface CrewMapper {

    void insertCrew(@Param("crew") Crew crew);
    List<Crew> getCrews(@Param("condition") Map<String, Object> condition);
    void getCrewDetailByNo(@Param("no") int crewNo);

}

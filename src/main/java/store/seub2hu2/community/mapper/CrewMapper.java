package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.CrewMember;

import java.util.List;
import java.util.Map;

@Mapper
public interface CrewMapper {

    void insertCrew(@Param("crew") Crew crew);
    void insertCrewMember(@Param("member") CrewMember member);
    List<Crew> getCrews(@Param("condition") Map<String, Object> condition);
    int getTotalRowsForCrew(@Param("condition") Map<String, Object> condition);
    Crew getCrewDetailByNo(@Param("no") int crewNo);
    void updateCrewCnt(@Param("crew") Crew crew);

}

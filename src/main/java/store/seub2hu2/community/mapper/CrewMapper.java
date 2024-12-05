package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.CrewMember;

import java.util.List;
import java.util.Map;

@Mapper
public interface CrewMapper {

    void insertCrew(@Param("crew") Crew crew);
    void insertCrewMember(@Param("member") CrewMember member);
    List<Crew> getCrews(@Param("condition") Map<String, Object> condition);
    List<CrewMember> getCrewMembers(@Param("no") int crewNo);
    int getTotalRowsForCrew(@Param("condition") Map<String, Object> condition);
    Crew getCrewDetailByNo(@Param("no") int crewNo);
    void updateCrewCnt(@Param("crew") Crew crew);

    void updateCrew(@Param("crew") Crew crew);
    void updateCrewCondition(@Param("no") int crewNo, @Param("condition") String condition);
    void updateCrewMember(@Param("member") CrewMember member);
    int getCrewMemberCnt(@Param("no") int crewNo);
}

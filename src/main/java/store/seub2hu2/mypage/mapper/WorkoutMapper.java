package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.mypage.dto.WorkoutDTO;

import java.util.List;

@Mapper
public interface WorkoutMapper {
    List<WorkoutDTO> getWorkoutByUserNo(@Param("userNo") int userNo);
}

package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.mypage.dto.WorkoutDTO;
import store.seub2hu2.mypage.mapper.WorkoutMapper;

import java.util.List;

@Service
public class WorkoutService {

    @Autowired
    private WorkoutMapper workoutMapper;

    public List<WorkoutDTO> getWorkoutByUserNo(int userNo){
        return workoutMapper.getWorkoutByUserNo(userNo);
    }
}

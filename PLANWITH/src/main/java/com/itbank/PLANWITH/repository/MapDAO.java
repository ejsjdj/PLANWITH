package com.itbank.PLANWITH.repository;

import java.util.List;

import com.itbank.PLANWITH.model.PlaceDTO;
import com.itbank.PLANWITH.model.ScheduleDTO;

public interface MapDAO {
	int selectPlace(PlaceDTO dto);

	void insertPlace(PlaceDTO dto);

	void deletePlace(PlaceDTO dto);
	
	int searchId(PlaceDTO dto);

	List<ScheduleDTO> selectScheduleListByTeamId(int teamId);

	void insertSchedule(ScheduleDTO schedule);

	void deleteSchedule(ScheduleDTO schedule);

	void updateTime(ScheduleDTO scheduleDTO);

	int selectPlaceIdById(int id);

	PlaceDTO selectPlaceById(int placeId);
}

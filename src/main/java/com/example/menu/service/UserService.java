package com.example.menu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.menu.dao.UserDao;
import com.example.menu.entity.User;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;

	@Transactional(readOnly = true)
	public User findById(long id) {
		return userDao.findById(id);
	}

	@Transactional(readOnly = true)
	public User findByName(String name) {
		return userDao.findByName(name);
	}
	
	@Transactional(readOnly = true)
	public List<User> listUsers() {
		return userDao.listUsers();
	}
}

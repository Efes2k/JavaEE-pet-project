package org.spring.mvc.web;

import java.awt.Color;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.log4j.Logger;
import org.spring.mvc.dao.UserDAO;
import org.spring.mvc.entity.MyFriends;
import org.spring.mvc.entity.User;
import org.spring.mvc.entity.message.Comment;
import org.spring.mvc.entity.message.MediaType;
import org.spring.mvc.entity.message.Message;
import org.spring.mvc.entity.message.MessageMedia;
import org.spring.mvc.exception.AccessDeniedException;
import org.spring.mvc.exception.DalException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = "/list", method = RequestMethod.GET)
public class ListController {

	@Autowired
	private UserDAO userDao;
	
	private static final Logger logger = Logger.getLogger(LoginController.class);

	
	@RequestMapping(method = RequestMethod.GET)
	public String homePage(Model model) throws DalException {
		User user = getPrincipal();
		model.addAttribute("userInfo", user);
		
		return "redirect:/list/" + user.getUsername();
	}

	@RequestMapping(value = "/{username}")
	public String showProfile(@PathVariable String username, Model model) throws DalException, IOException, AccessDeniedException {
		User user = userDao.findByName(username);
		validateUser(user);
		model.addAttribute("messList", userDao.getUserMessages("where_id", user.getId()));
		model.addAttribute("userInfo", user);

		if (validateSubcriber(username)) model.addAttribute("subOk", "true");
		else model.addAttribute("subOk", "false");
		logger.info(getPrincipal().getId() +  " go to profile: " +  user.getId());
		return "list";
	}

	// Validate subscriber
	private boolean validateSubcriber(String username) throws DalException {
		User me = getPrincipal();
		User friend = userDao.findByName(username);
		User principal = userDao.findByName(me.getUsername());
		boolean status = false;
		for (MyFriends fr : principal.getMyFriends()) {
			if (fr.getMyFriend().getUsername().equals(friend.getUsername())){
				status = true;
				break;
			}
			else status = false;
		}
		
		logger.info(getPrincipal().getId() + " friend of: " + principal.getId() + " is " + status);
		return status;
	}

	@RequestMapping(value = "/{username}/removeFriend")
	@ResponseBody public void removeFriend(@RequestParam String username) throws DalException {
		findFriendToDelete(username);
	}

	// find friend to delete
	private void findFriendToDelete(String username) throws DalException {
		User me = userDao.findByName(getPrincipal().getUsername());
		MyFriends temp = null;
		
		for (int i = 0; i < me.getMyFriends().size(); i++) {
			temp = me.getMyFriends().get(i);
			if (temp.getMyFriend().getUsername().equals(username)) {
				me.getMyFriends().remove(i);
				logger.info(getPrincipal().getId() + " remove friend: " + temp.getId());
				userDao.deleteFriend(temp.getId());
			}
		}
	}

	@RequestMapping(value = "/{username}/addFriend")
	@ResponseBody public void addFriend(@RequestParam String username) throws DalException {
		User user = getPrincipal();
		User friend = userDao.findByName(username);
		MyFriends fr = new MyFriends(user, friend);
		userDao.save(fr);
		logger.info(user.getId() + " add friend w id:  " + friend.getId());
	}

	@RequestMapping(value = "/{username}/addMessage",method = RequestMethod.POST)
	public String addMessage(@PathVariable String username,	@ModelAttribute Message message, @RequestParam(value = "imageMess", required = false) MultipartFile image,
								Model model,HttpServletRequest req) throws DalException, IOException {
		User user = getPrincipal();
		MessageMedia messMedia = new MessageMedia();
		
		message.setType("empty");
		if (!image.isEmpty()) {
			if (validateImage(image)) {
				messMedia = new MessageMedia(image.getBytes(), image.getContentType(),	image.getOriginalFilename());
				message.setType(image.getContentType());
			}
		}
		userDao.save(messMedia);

		User where = userDao.findByName(username);
		message.setMessMedia(messMedia);
		message.setWhere(where);
		message.setOwner(user);
		userDao.save(message);
		logger.info(user.getId() + " add messege on " + where.getId());
		return "redirect:/list/{username}";
	}

	@ModelAttribute("message")
	public Message populateMessage() {
		return new Message();
	}

	@RequestMapping(value = "/{username}/removeMessage/{id}", method = RequestMethod.POST)
	public String removeMessage(@PathVariable String username, @PathVariable int id) throws DalException {
		userDao.deleteMessage(id);
		logger.info("Remove messege " + id);
		return "redirect:/list/{username}";
	}

	@RequestMapping(value = "/{username}/addComment", method = RequestMethod.POST)
	@ResponseBody public Comment addComment(@RequestParam String commentText, @RequestParam int messageId) throws DalException {
		Comment comment = new Comment();
		comment.setText(commentText);
		comment.setAuthor(getPrincipal());
		comment.setMessageWhere(userDao.find(Message.class, messageId));
		userDao.save(comment);
		logger.info(getPrincipal().getId() + " add comment on messege: " + messageId);
		return comment;
	}

	@RequestMapping(value = "/{username}/removeComment/{id}", method = RequestMethod.POST)
	@ResponseBody public String removeComment(@PathVariable int id,	@PathVariable String username) throws DalException {
		userDao.delete(Comment.class, id);
		logger.info(getPrincipal().getId() + " remove comment: " + id);
		return "ok";
	}

	@RequestMapping(value = "/{username}/addAvatar", method = RequestMethod.POST)
	public String addAvatar(@PathVariable String username, @RequestParam MultipartFile image) throws IOException, DalException {
		if (!image.isEmpty()) {
			validateImage(image);
			User user = userDao.findByName(username);
			user.setAvatar(image.getBytes());
			userDao.changeAvatar(user);
		}
		logger.info(getPrincipal().getId() + " change avatar");
		return "redirect:/list/{username}/settings";
	}
	
	// Validate image
		private boolean validateImage(MultipartFile image) {
			if (!MediaType.getInstance().getTypeList().contains(image.getContentType())) {
				logger.info("Bad message's contentType: " + image.getContentType());
				return false;
			}
			return true;
		}


	@RequestMapping(value = "/{username}/imageDisplay")
	@ResponseBody public byte[] showImage(@PathVariable String username,@RequestParam String scale, @RequestParam Integer h,
										  @RequestParam Integer w) throws IOException, DalException {
		User user = userDao.findByName(username);
		if (scale.equals("true") && (user.getAvatar() != null)) {
			return scale(user.getAvatar(), w, h);
		}
		return user.getAvatar();
	}

	@RequestMapping(value = "/{username}/imageDisplay/{id}")
	@ResponseBody public byte[] showImageMessege(@PathVariable String username,	@PathVariable Integer id, @RequestParam String scale)
																									throws IOException, DalException {
		Message message = userDao.find(Message.class, id);

		if (scale.equals("true") && (message.getMessMedia().getMedia() != null)) {
			return scale(message.getMessMedia().getMedia(), 150, 150);
		}
		return message.getMessMedia().getMedia();
	}

	@RequestMapping(value = "/{username}/myFriends")
	public String myFriends(@PathVariable String username, Model model)	throws DalException, AccessDeniedException {
		User userPr = getPrincipal();
		User user = userDao.findByName(userPr.getUsername());
		
		validateUser(user,username);
		model.addAttribute("friendList", user.getMyFriends());
		logger.info(getPrincipal().getId() + " go to page MyFriends" );
		return "myfriends";
		
	}

	@RequestMapping(value = "/{username}/gallery")
	public String gallery(@PathVariable String username, Model model) throws DalException, AccessDeniedException {
		User userPr = getPrincipal();
		User user = userDao.findByName(userPr.getUsername());
		
		validateUser(userPr, username);
		model.addAttribute("galleryList", userDao.getUserMessages("user_id", user.getId()));
		logger.info(getPrincipal().getId() + " go to page Gellery" );
		return "gallery";
		
	}

	@RequestMapping(value = "/{username}/contactUs")
	public String contactUs(@PathVariable String username, Model model)	throws DalException, AccessDeniedException {
		User userPr = getPrincipal();
		User user = userDao.findByName(userPr.getUsername());
		
		validateUser(user,username);
		logger.info(getPrincipal().getId() + " go to page contactUs" );
		return "contactUs";
	}

	@RequestMapping(value = "/{username}/administration")
	public String adminPage(@PathVariable String username, Model model)	throws DalException {
		logger.info(getPrincipal().getId() + " go to admin page" );
		return "administration";
	}

	@RequestMapping(value = "/{username}/settings")
	public String settings(@PathVariable String username, Model model) throws DalException, AccessDeniedException {
		User userPr = getPrincipal();
		
		validateUser(userPr, username);
		logger.info(getPrincipal().getId() + " go to page Settings" );
		return "settings";
	}

	@RequestMapping(value = "/{username}/settings/fieldChange", method = RequestMethod.POST)
	@ResponseBody public  User settitgsChange(@RequestParam String fieldId, @RequestParam String changes) throws DalException {
		userDao.changeField(fieldId, changes, getPrincipal().getId());
		return userDao.find(User.class, getPrincipal().getId());
	}

	@RequestMapping(value = "/credentials/{username}")
	public String settingsForAdmin(@PathVariable String username, Model model) throws DalException {
		model.addAttribute("userInfo", userDao.findByName(username));
		return "administration";
	}

	@RequestMapping(value = "/credentials/{username}/removeUser")
	public String removeUser(@PathVariable String username, Model model) throws DalException {
		User userPr = getPrincipal();
		userDao.deleteUser(userDao.findByName(username).getId());
		return "redirect:/list/" + userPr.getUsername();
	}

	@RequestMapping(value = "/credentials/{username}/statusChange", method = RequestMethod.POST)
	@ResponseBody public boolean statusChange(@PathVariable String username, @RequestParam String status) throws DalException {

		User user = userDao.findByName(username);
		userDao.changeStatus("accountNonLocked", Boolean.parseBoolean(status), user.getId());
		return Boolean.parseBoolean(status);
	}

	// Scaling image
	public byte[] scale(byte[] fileData, int width, int height)	throws IOException {

		ByteArrayInputStream in = new ByteArrayInputStream(fileData);
		try {
			BufferedImage img = ImageIO.read(in);
			if (height == 0) {
				height = (width * img.getHeight()) / img.getWidth();
			}
			if (width == 0) {
				width = (height * img.getWidth()) / img.getHeight();
			}
			Image scaledImage = img.getScaledInstance(width, height,
					Image.SCALE_SMOOTH);
			BufferedImage imageBuff = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			imageBuff.getGraphics().drawImage(scaledImage, 0, 0,
					new Color(0, 0, 0), null);

			ByteArrayOutputStream buffer = new ByteArrayOutputStream();

			ImageIO.write(imageBuff, "jpg", buffer);

			return buffer.toByteArray();
		} catch (IOException e) {
			logger.warn("IOException in scale:" + e.getMessage() );
			throw new IOException("IOException in scale");
		}
	}

	// Validate user
	public void validateUser(User user) throws  AccessDeniedException {
		if (user == null) {
			logger.warn("user not found");
			throw new AccessDeniedException("");
		}
	}
	
	public void validateUser(User user,String username) throws  AccessDeniedException {
		if(!user.getUsername().equals(username)) {
			logger.warn(user.getUsername() + "/" + user.getId() + " try to access " + username);
			throw new AccessDeniedException("");
		}
	}
	
	// Get authorizet user
	private User getPrincipal() {
		return (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}

}

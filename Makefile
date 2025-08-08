# **************************************************************************** #
#                                   SETTINGS                                   #
# **************************************************************************** #

NAME	= so_long
CC		= gcc
CFLAGS	= -Wall -Wextra -Werror
RM		= rm -f

# Directories
SRC_DIR	= src
OBJ_DIR	= obj
INC_DIR	= includes

# Find all .c in SRC_DIR
SRC		= $(wildcard $(SRC_DIR)/*.c)
OBJ		= $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC))

# **************************************************************************** #
#                                   RULES                                      #
# **************************************************************************** #

all: $(NAME)

$(NAME): $(OBJ)
	@echo "🔨 Linking $(NAME)"
	$(CC) $(CFLAGS) $(OBJ) -o $(NAME) -I $(INC_DIR)

# Rule to compile .c to .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	@echo "⚙️  Compiling $<"
	$(CC) $(CFLAGS) -I $(INC_DIR) -c $< -o $@

# Create OBJ_DIR if it does not exist already
$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

clean:
	@echo "🗑️  Deleting object files..."
	@$(RM) -r $(OBJ_DIR)

fclean: clean
	@echo "🗑️  Deleting $(NAME)..."
	@$(RM) $(NAME)

re: fclean all

# Norminette and testing
test: re
	@echo "📝 Checking Norminette..."
	@norminette -R CheckForbiddenSourceHeader -R CheckDefine $(SRC) $(wildcard $(INC_DIR)/*.h)
	@echo "✅ Norminette check finished"

.PHONY: all clean fclean re test

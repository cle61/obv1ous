class Admin::TeamMembersController < Admin::DashboardController
	#http://ddragon.leagueoflegends.com/cdn/5.22.3/img/champion/TahmKench.png

	@weapons = ['M4A1-s',
				'M4A4',
				'AWP',
				'P90',
				'Five-seveN',
				'Deagle',
				'AK-47',
				'SSG 08']

	@champions = ['Jinx',
				'Tristana',
				'Lucian',
				'Thresh',
				'Braum',
				'Orianna',
				'Anivia',
				'Tahm Kench']

	@rank_cs = ['',
				'Silver I',
				'Silver II',
				'Silver III',
				'Silver IV',
				'Silver Elite',
				'Silver Elite Master',
				'Gold Nova I',
				'Gold Nova II',
				'Gold Nova III',
				'Gold Nova Master',
				'Master Guardian I',
				'Master Guardian II',
				'Master Guardian Elite',
				'Distinguished Master Guardian',
				'Legendary Eagle',
				'Legendary Eagle Master',
				'Supreme Master First Class',
				'The Global Elite',
				]

	@rank_lol = ['',
				'Bronze 5',
				'Bronze 4',
				'Bronze 3', 
				'Bronze 2',
				'Bronze 1', 
				'Silver 5',
				'Silver 4',
				'Silver 3',
				'Silver 2',
				'Silver 1',
				'Gold 5',
				'Gold 4',
				'Gold 3',
				'Gold 2',
				'Gold 1',
				'Platine 5',
				'Platine 4',
				'Platine 3',
				'Platine 2',
				'Platine 1',
				'Diamond 5',
				'Diamond 4',
				'Diamond 3',
				'Diamond 2',
				'Diamond 1',
				'Master',
				'Challenger']

	@role_lol = ['',
				 'Top',
				 'Jungle',
				 'Mid',
				 'ADC',
				 'Support']

	@role_lol = ['',
				 'Open Frag',
				 'AWP',
				 'Support']

	@games = ['CS-GO',
			  'League Of Legends',
			  'Rust',
			  'Block N Load',
			  'Rocket League',
			  'Minecraft']

	def index
		@members = TeamMember.order('id desc')
	end

	def new
		@member = TeamMember.new
		@member.team_members_game.build

		#@member_games = TeamMembersGame.new
		#@member_weapons = TeamMembersWeapon.new
		#@member_champions = TeamMembersChampion.new

		#@member_games = @member.team_members_games.build
		#@member_weapons = @member.team_members_weapons.build
		#@member_champions = @member.team_members_champions.build
	end

	def create
		@member = TeamMember.new(team_member_params)
	    if @member.save
	        redirect_to edit_admin_team_member_path(@member.id), notice: 'Le membre a bien été créé'
	    else
	        render 'new'
	    end
	end

	def edit
		@member = TeamMember.find(params[:id])

		@member_game = @member.team_members_games
		#@member = TeamMember.joins(:TeamMembersChampion, :TeamMembersWeapon, :TeamMembersGame)
	end

	def update
		@member = TeamMember.find(params[:id])

	    if @member.update_attributes(member_params)
	      # Handle a successful update.
	      redirect_to edit_admin_team_member_path(@member.id), notice: 'Le membre a bien été modifié'
	    else
	      render 'edit'
	    end
	end

	def destroy
		TeamMember.destroy(params[:id])
		redirect_to admin_team_members_path, notice: 'Le membre a bien été supprimé'
	end

	private

    def member_params
      	params.require(:team_member).permit(:name, :id_steam, :color, :avatar, :avatar_color, :description, :rank_cs, :rank_lol, :role_cs, :role_lol, team_members_game: [:id, :name_game])
    end

    def team_member_params
	    params.require(:team_member).permit(:name, :id_steam, :color, :avatar, :avatar_color, :description, :rank_cs, :rank_lol, :role_cs, :role_lol, team_members_game_attributes: [ :id, :team_member_id, :name_game])
	end

    def team_member_game_params
    	params.require(:team_members_game).permit(:team_member_id, :name_game)
    end

    def member_weapons_params
    	params.require(:team_members_weapon).permit(:team_member_id, :name_weapon)
    end

    def member_champions_params
    	params.require(:team_members_champion).permit(:team_member_id, :name_champion)
    end

end

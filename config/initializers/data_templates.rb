# frozen_string_literal: true

# Database like data. Usually such templates can be stored in DB or files.

IMPORT_TEMPLATE = %q{
	Company Id: %company_id%
	Company Name: %company_name%
	Users Emailed:%users_emailed%
	Users Not Emailed:%users_not_emailed%
		Total amount of top ups for %company_name%: %company_total_topups%
}

IMPORT_USER_TEMPLATE = %q{
		%last_name%, %first_name%, %email%
		  Previous Token Balance, %previous_tokens_size%
		  New Token Balance %new_tokens_size%}

class Pokemon < ApplicationRecord
    validates :name, presence: true, format: { with: /[a-zA-Z]/ }
    validates :type1, presence: true, format: { with: /[a-zA-Z]/ }
    validates_format_of :type2, :with => /[a-zA-Z]/, :allow_blank => true
    validates :hp, presence: true, numericality: { only_integer: true}
    validates :attack, presence: true, numericality: { only_integer: true}
    validates :defense, presence: true, numericality: { only_integer: true}
    validates :spatk, presence: true, numericality: { only_integer: true}
    validates :spdef, presence: true, numericality: { only_integer: true}
    validates :speed, presence: true, numericality: { only_integer: true}
    validates :generation, presence: true, numericality: { only_integer: true}
    validates :legendary, inclusion: { in: [true, false] }
    validate :pokemon_total_is_sum_of_all_stats
    after_initialize :setup_values

    private 
    def pokemon_total_is_sum_of_all_stats
        total_stats = self.hp + self.attack + self.defense + self.spatk + self.spdef + self.speed

        if !changed.empty? && !changed.include?("total")
            self.total = total_stats
        end

        if self.total != nil && self.total != total_stats
            errors.add(:base, "Total value does not equal to the sum of all its stats")
        end
    end

    def setup_values
        self.total ||= self.hp + self.attack + self.defense + self.spatk + self.spdef + self.speed
    end
end

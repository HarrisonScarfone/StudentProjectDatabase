module Projects
    class RandomProjectQuery
      def perform
        Project.all.order('RANDOM()').first
      end
    end
  end
  
  
      